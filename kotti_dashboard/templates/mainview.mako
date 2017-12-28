
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta charset="utf-8" />
    <title>Login Welcome to Kotti - Welcome to Kotti</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="Congratulations! You have successfully installed Kotti." />
    <script>
      kotti_context_url = '${request.resource_url(request.context)}'
    </script>
  </head>
  <body>
    <script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '1508237436143014',
      xfbml      : true,
      version    : 'v2.5'
    });
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
</script>
  </body>
</html>
