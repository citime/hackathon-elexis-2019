(:~
 : This file contains the tunico project webapp.
 : It consists of several modules.
 : Dependencies: BaseX with "hackathon19" database and stored "dc_aeb_eng.xml"
 : @author citime
 :)
module namespace page = "http://basex.org/modules/web-page";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
import module namespace functx = "http://www.functx.com";

(:~
 : This function generates the main page.
 : @return HTML page
 :)
declare
  %rest:path("/tunico")
  %rest:method("get")
  %output:method("html")
  %output:html-version("5.0")
  function page:start()
{ 
  <html lang="en">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>TuniCo Roots Project</title>

      <link href="../static/tunico/custom_bootstrap.css" rel="stylesheet"></link>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css" />
      <script src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
      <style>
        main {{
          margin-top: 58px;
          padding-top: 2em;
        }}
        #network {{
          width: 100%;
          height: 400px;
        }}
        #group a {{
          padding: 4px 10px;
        }}
        .navbar-dark .navbar-toggler {{
          border-color: transparent;
        }}
      </style>
    </head>
    <body>
      <nav class="navbar navbar-expand-md navbar-dark bg-primary fixed-top">
        <a class="navbar-brand" href="#">TuniCo Roots</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsExampleDefault">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <a class="nav-link" href="/tunico/about">About this project</a>
            </li>
          </ul>
        </div>
      </nav>

     {
      let $db := db:open("hackathon19", "dc_aeb_eng.xml")
      let $entries := $db//tei:entry
      return
      <main role="main" class="container">

        <h1>Explore {count(distinct-values($entries/tei:gramGrp/tei:gram[@type eq "root"]/text()))} roots</h1>
        <blockquote class="blockquote text-right">
          <p class="mb-0">getting access to {count($entries)} lexical entries</p>
        </blockquote>
        <div class="row mt-2">
          <div class="col-3">
            <p class="font-weight-bold">Choose the position of the consonant:</p>
          </div>
          <div id="positionletter" class="col-lg-6 col-sm-12">
            <button id="btninitial" type="button" class="btn btn-info text-dark">Initial</button>
            <button id="btnmiddle" type="button" class="btn btn-outline-info text-dark">Middle</button>
            <button id="btnfinal" type="button" class="btn btn-outline-info text-dark">Final</button>
          </div>
        </div>
        <div class="row mt-2"> 
          <div class="col-3">
            <p class="font-weight-bold">Choose a consonant:</p>
          </div>
          <div id="group" class="col-lg-6 col-sm-12">
          </div> 
        </div>
        <div class="row mt-4">
          <div id="leftcol" class="col-lg-6 col-sm-12">
          </div>
          <div class="col-lg-6 col-sm-12 mt-4">
            <p id="pwordform" class="font-weight-bold">Click on specific word form to get more information</p>
            <div id="network" class="border border-dark"></div>
          </div>
        </div>
        <div id="terminformation" class="row mt-4"></div>
        <div id="lexical" class="row mt-4">
        </div>
        <div id="translations"></div>
      </main>
     }
    </body>
    <script type="text/javascript" src="../static/tunico/js/tunico.js"></script>
  </html>
};


(:~
 : This function generates the about page.
 : @return HTML page
 :)
declare
  %rest:path("/tunico/about")
  %rest:method("get")
  %output:method("html")
  %output:html-version("5.0")
  function page:about()
{ 
  <html lang="en">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>TuniCo Roots Project</title>

      <link href="../static/tunico/custom_bootstrap.css" rel="stylesheet"></link>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css" />
      <script src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
      <style>
        main {{
          margin-top: 58px;
          padding-top: 2em;
        }}
        .navbar-dark .navbar-toggler {{
          border-color: transparent;
        }}
      </style>
    </head>
    <body>
      <nav class="navbar navbar-expand-md navbar-dark bg-primary fixed-top">
        <a class="navbar-brand" href="/tunico">TuniCo Roots</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsExampleDefault">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <a class="nav-link" href="#">About this project</a>
            </li>
          </ul>
        </div>
      </nav>
      <main role="main" class="container">
        <h1>About this project</h1>
        <p>This web application was developed as a part of the ACDH hackathon series 2019: ELEXIS hack. For
        more information visit <a href="https://github.com/acdh-oeaw/ACDHhackathonELEXIS">the repository on GitHub</a>.</p>
        <p>The application was created with BaseX and RESTXQ. The provided dataset is stored in the database. For the interaction JavaScript, jQuery and vis.js was used. Bootstrap 4 is the CSS framework.</p>
        <p>TuniCo Roots allows to explore the dataset by radical consonants and roots.</p>
        <p>After clicking a radical position, a radical consonant can be chosen. As a result,
        a list of possible roots is displayed. Click on a root to get the visualization.
        It shows all relatives of the clicked root. Further information is shown
        when clicking on a specific word form. OmegaWiki and lexvo.org are used as external sources to
        provide definitions and translations. A link to the main TuniCo project and to the
        Wiktionary entry is provided.</p>
        <p></p>
      </main>
    </body>
  </html>       
};

(:~
 : Given a letter and its position, this function extracts all matching roots from the database.
 : @return div
 :)
declare
  %rest:path("/tunico/getroots/{$letter}/{$position}")
  %rest:method("get")
  %output:method("html")
  function page:getroots($letter as xs:string, $position as xs:string)
{ 
  let $db := db:open("hackathon19", "dc_aeb_eng.xml")
  let $roots := if ($position eq "initial") then $db//tei:entry//tei:gramGrp/tei:gram[@type eq "root" and starts-with(./text(), $letter)] else if ($position eq "final") then  $db//tei:entry//tei:gramGrp/tei:gram[@type eq "root" and ends-with(./text(), $letter)] else  $db//tei:entry//tei:gramGrp/tei:gram[@type eq "root" and contains(substring(./text(), 2,  string-length(./text())-2), $letter)]
  return
  <div id="allroots" class="ml-0 pl-0">
    <p class="font-weight-bold">Choose a root:</p>
   {
    for $root in distinct-values($roots)
    order by $root ascending
    return
    <a type="button" role="button" class="btn btn-sm">{$root}</a>
  }</div>
};

(:~
 : This function generates a link list of all letters in a specific (initial, middle, final) position of a root.
 : @return link list
 :)
declare
  %rest:path("/tunico/getletters/{$position}")
  %rest:method("get")
  %output:method("html")
  function page:getletters($position as xs:string)
{ 
  let $db := db:open("hackathon19", "dc_aeb_eng.xml")
  let $entries := $db//tei:entry
  
  let $initials := distinct-values(for $text in $entries/tei:gramGrp/tei:gram[@type eq "root"]/text() return substring($text, 1, 1))
  let $finals := distinct-values(for $text in $entries/tei:gramGrp/tei:gram[@type eq "root"]/text() return substring($text, string-length($text)-1, 1))
  let $middles := distinct-values(for $text in $entries/tei:gramGrp/tei:gram[@type eq "root"]/text() return functx:chars(substring($text, 2,  string-length($text)-2)))
  (: Combining dot below needs special treatment in the future, for now it is excluded :)
  let $exclusive := ("̣", " ", "")
  
  (: Return according to position :)
  return
  if ($position eq "initial") then
  for $letter in $initials
  order by $letter
  return
  <a href="#">{$letter}</a>
  else if ($position eq "final") then
  for $letter in $finals[not(. = $exclusive)]
  order by $letter
  return
  <a href="#">{$letter}</a>
  else
  for $letter in $middles[not(. = $exclusive)]
  order by $letter
  return
  <a href="#">{$letter}</a>
};

(:~
 : This function requests all relative words to a given root. E. g. relatives to ktb are ktib, maktib, ktub, etc.
 : It is used to create the visualization.
 : @return json array
 :)
declare
  %rest:path("/tunico/root/{$root}")
  %rest:method("get")
  %output:method("json")
  function page:rootlookup($root as xs:string)
{ 
  let $db := db:open("hackathon19", "dc_aeb_eng.xml")
  let $relatives := $db//tei:entry//tei:gramGrp/tei:gram[@type eq "root" and ./text() eq $root]
  return
  array{$relatives/../preceding-sibling::tei:form/tei:orth/text()}
};

(:~
 : This function requests all possible translations for a lemma from the database.
 : It is used for the hover tooltip of the network.
 : @return paragraphs with translation
 :)
declare
  %rest:path("/tunico/translation/{$lemma}")
  %rest:method("get")
  %output:method("html")
  function page:translate($lemma as xs:string)
{ 
  let $db := db:open("hackathon19", "dc_aeb_eng.xml")
  let $entry := $db//tei:entry/tei:form/tei:orth/text()[. eq $lemma]
  for $translation in $entry/ancestor::tei:entry/tei:sense/tei:cit/tei:quote/text()
  return
  <p>{$translation}</p>
};

(:~
 : This function requests the English translation for a lemma from the database.
 : It is used for requesting further information of OmegaWiki.
 : $root is necessary to distinguish homonyms
 : @return all english translations
 :)
declare
  %rest:path("/tunico/engltransl/{$lemma}/{$root}")
  %rest:method("get")
  %output:method("json")
  function page:engltranslation($lemma as xs:string, $root as xs:string)
{ 
  let $db := db:open("hackathon19", "dc_aeb_eng.xml")
  let $entry := $db//tei:entry/tei:form/tei:orth/text()[. eq $lemma and ./ancestor::tei:entry/tei:gramGrp/tei:gram[@type eq "root"]/text() eq $root]
  let $allengltranslations := array{for $translation in $entry/ancestor::tei:entry/tei:sense/tei:cit[@xml:lang eq "en"]/tei:quote/text() return $translation}
  return
  $allengltranslations
};

(:~
 : This function requests OmegaWiki to get the definition of the term.
 : @return div with definition
 :)
declare
  %rest:path("/tunico/omegadefinition/{$term}")
  %rest:method("get")
  %output:method("html")
  function page:omegadefinition($term as xs:string)
{ 
  let $path := "http://www.omegawiki.org/api.php?action=ow_express&amp;ver=1.1&amp;search=" || $term || "&amp;format=xml"
  let $response := http:send-request(<http:request method="get"/>, $path)
  let $definition := $response//definition[@lang eq "English"]/@text
  return
  <div class="col">
    <h3>Definitions of the English term {$term}</h3>
    <p>This section lists possible definitions for the given term. Note that these definitions could refer to homonyms.</p><p>This information is requested from OmegaWiki. Click on the link <emph>Translation</emph> of the definition to get all translations from OmegaWiki.</p>
    {if ($definition) then
    <ul id="definitions"> 
     {
      for $def in $definition
      return
      <li>{data($def)} <a id="{data($def/../../@dmid)}" href="#"> Translation</a></li>
     }
    </ul>
    else 
    <p>No definitions found.</p>
  }
  </div>
};


(:~
 : This function requests omegawiki to get possible translations.
 : @return div with table of translations
 :)
declare
  %rest:path("/tunico/omegatransl/{$dmid}")
  %rest:method("get")
  %output:method("html")
  function page:omegatransl($dmid as xs:string)
{ 
  let $path := "http://www.omegawiki.org/api.php?action=ow_syntrans&amp;dm=" || $dmid || "&amp;format=xml"
  let $response := http:send-request(<http:request method="get"/>, $path)
  return
  <div>
    <h3>Translations</h3>
    <table class="table">
     {
      for $entry in $response//ow_syntrans/*
      order by $entry/@lang 
      return 
      <tr><td>{data($entry/@lang)}</td><td>{data($entry/@e)}</td></tr>
     }
    </table>
  </div>
};

(:~
 : This function requests lexvo.org to get a wiktionary link.
 : Additionally, the lexvo.org page is returned.
 : @return div with links to external resources
 :)
declare
  %rest:path("/tunico/lexvo/{$term}")
  %rest:method("get")
  %output:method("html")
  function page:termlookup($term as xs:string)
{ 
  let $path := "http://www.lexvo.org/data/term/eng/" || $term
  let $response := http:send-request(<http:request method="get"/>, $path)
  return
  <div id="externallinks" class='row mt-2'>
    <div class='col text-right'>
      <a href="{data($response//rdfs:seeAlso/@rdf:resource)}">Link to Wiktionary {$term}</a>
      <br/>
      <a href="{'http://www.lexvo.org/page/term/eng/' || $term}">Link to lexvo.org {$term}</a>
    </div>
  </div>
};

(:~
 : This function requests information on the lemma from the database.
 : $root is necessary to distinguish homonyms
 : @return 
 :)
declare
  %rest:path("/tunico/terminformation/{$lemma}/{$root}")
  %rest:method("get")
  %output:method("json")
  function page:terminformation($lemma as xs:string, $root as xs:string)
{ 
  let $db := db:open("hackathon19", "dc_aeb_eng.xml")
  let $entry := $db//tei:entry/tei:form/tei:orth/text()[. eq $lemma and ./ancestor::tei:entry/tei:gramGrp/tei:gram[@type eq "root"]/text() eq $root]
  let $etym := array{$entry/ancestor::tei:entry/tei:etym/text()}
  let $etymlang := $entry/ancestor::tei:entry/tei:etym/tei:lang/text()
  let $etymmentioned := $entry/ancestor::tei:entry/tei:etym/tei:mentioned/text()
  let $pos := $entry/ancestor::tei:entry/tei:gramGrp/tei:gram[@type eq "pos"]/text()
  let $subc := $entry/ancestor::tei:entry/tei:gramGrp/tei:gram[@type eq "subc"]/text()
  return
  array{$entry[1], map{"pos": array{$pos}, "subc": array{$subc}, "etym": array{$etym, $etymlang, $etymmentioned}}}
};