/***********************************************************
*   Auxiliar javascript functions                          *
*   NOTE: All code here must use $j instead of $ for       *
*   jquery to avoid javascript conflict                    *
***********************************************************/

$j(document).ready(function() {

  // Add show_hide link to all code blocks
  $j('div.codigo').prepend('<a href="#">Show Code</a>').
    find('pre').addClass('codigo_plegado');

  //Handle code a
  $j('div.codigo a').click(function() {
    if ($j(this).parent('div').find('pre').hasClass('codigo_plegado')){
      $j(this).parent('div').find('pre').
        removeClass('codigo_plegado').addClass('codigo_desplegado');
      $j(this).html('Hide Code');
    }
    else {
        $j(this).parent('div').find('pre').
        addClass('codigo_plegado').removeClass('codigo_desplegado');
      $j(this).html('Show Code');
    }
    return false;
  });
});