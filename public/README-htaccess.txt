o Tested using Apache version 2.2.15, Rails 3.0.3.

o Environment variables cannot be set under cPanel (at least mine). For troubleshooting, in order to show Apache variables, remove '# SHOW' from the RewriteRule directives, e.g.:
    RewriteRule ^(.+)$ /your_app_name/$1.html?dr=%{DOCUMENT_ROOT}&ru=%{REQUEST_URI}&rf=%{REQUEST_FILENAME} [L,R=301]

o Seamonkey caches strangely, so use the browser, Opera to test your application.

o These rewrite rules require you to make this symlink:
    /home/your_user_name/public_html/your_app_name ->
    /home/your_user_name/rails_apps/your_app_name/public

o At least in Rails 3.0.3, the following config/application.rb statement, which allows your application to generate the proper sub-URI URL's for its static assets such as images, requires an extra '/your_app_name' in the RewriteCond directive (rewrite 2.1.2) for most cached pages:

    config.action_controller.asset_path=proc{|p| "/your_app_name#{p}"}

o Note that cPanel users cannot change Apache's system-level configuration file (/usr/local/apache/conf/httpd.conf), for instance to add Alias directives, so the following applies:

    'The most common situation in which mod_rewrite is the right tool is when the very best solution requires access to the server configuration files, and you don't have that access. Some configuration directives are only available in the server configuration file. So if you are in a hosting situation where you only have .htaccess files to work with, you may need to resort to mod_rewrite.' --from http://httpd.apache.org/docs/current/rewrite/avoid.html

o The Pattern argument to RewriteRule must be without leading slash (it is stripped by Apache) or trailing slash. Its Substitution argument must have the leading slash.

o Apache's directive, DirectorySlash redirects bare sub-URI requests to '/your_app_name/', since 'your_app_name' is a symlink to your app's directory, 'public'. Similarly, Apache normally redirects bare HTTP_HOST requests to '/' because 'public_html' is a directory.

o Per: httpd-docs-2.2.14.en/mod/mod_rewrite.html#rewriterule
    Per-directory Rewrites: When using the rewrite engine in .htaccess files the per-directory prefix (which always is the same for a specific directory) is automatically removed for the pattern matching and automatically added after the substitution has been done.

o These failed:
    RewriteCond %{DOCUMENT_ROOT}/your_app_name/%{REQUEST_URI} !-f
    SetEnv app_name your_app_name
    RewriteRule ^ - [E:app_name:your_app_name]
    RequestHeader set 

o Apache's <if> directive is unavailable until version 2.3, per:
    http://serverfault.com/questions/238832/how-should-i-use-the-if-directive-in-htaccess

o Apache's FallbackResource directive is unavailable until version 2.2.16, per:
    http://httpd.apache.org/docs/2.2/mod/mod_dir.html#fallbackresource

o Apache's RedirectMatch directive is incapable of fixing a missing subdomain, 'www', since it accepts only a URL path without HTTP host.

o My file, 'public_html/.htaccess' has these directives regarding cache expiration:

  # Requires mod_expires to be enabled.
  <IfModule mod_expires.c>
  # Enable expirations.
  ExpiresActive On
  # Cache all files for 2 weeks after access (A).
  ExpiresDefault A1209600
  # Do not cache dynamically generated pages.
  ExpiresByType text/html A1
  </IfModule>

o TODO: maybe disallow original URI's suffixed with '.html'.

o References:
  http://httpd.apache.org/docs/2.2/
  http://httpd.apache.org/docs/2.2/mod/quickreference.html
  http://httpd.apache.org/docs/2.2/rewrite/
  http://httpd.apache.org/docs/2.2/mod/mod_rewrite.html
  http://httpd.apache.org/docs/1.3/mod/mod_rewrite.html  (simpler)
  http://httpd.apache.org/docs/2.2/rewrite/vhosts.html
  http://wiki.apache.org/httpd/WhenNotToUseRewrite
  http://borkweb.com/story/apache-rewrite-cheatsheet
  http://www.askapache.com/htaccess/crazy-advanced-mod_rewrite-tutorial.html
