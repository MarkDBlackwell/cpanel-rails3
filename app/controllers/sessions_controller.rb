class SessionsController < ApplicationController

  def destroy
    stop_server unless STARTED_BY_RAKE
  end

#-------------
  private

  WEBRICK_PID_PATH=App.root.join *%w[ tmp pids server.pid ]
  WEBRICK_PID = begin
    f=File.new WEBRICK_PID_PATH.to_s, 'r'
    s=f.gets("\n").chomp "\n"
    f.close
    s.to_i if s.present?
  rescue Errno::ENOENT
    nil
  end
  APPLICATION_PID=Process.pid

  def stop_application(s)
    logger.info "I #{s}; sending INT to application PID #{APPLICATION_PID}"
    Process.kill 'INT', APPLICATION_PID
  end

  def stop_server
# Attempt to stop Webrick server gracefully by sending it SIGINT:
    webrick_killed=false
    if WEBRICK_PID.present? && WEBRICK_PID > 0
      begin
        logger.info "I sending INT to Webrick PID #{WEBRICK_PID}; application PID is #{APPLICATION_PID}"
        Process.kill 'INT', WEBRICK_PID
        webrick_killed=true
      rescue Errno::EINVAL, Errno::ESRCH
      end
    end
# Handle various unusual conditions:
    s=case
    when WEBRICK_PID.blank?
      'No Webrick server.pid file found'
    when (WEBRICK_PID <= 0)
      "Bad value in Webrick server.pid file: #{WEBRICK_PID}"
    when (WEBRICK_PID != APPLICATION_PID)
      "Server PID #{WEBRICK_PID} differs from application's: not Webrick?"
    when (!webrick_killed)
      "No process #{WEBRICK_PID}"
# TODO: Handle hung Webrick server?
    end
    stop_application s if s
  end

end
