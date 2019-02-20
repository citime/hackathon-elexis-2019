// drawing the vis.js network provided with the root and its relatives
function createNetwork(root, stringdata) {
  var nodeset = [];
  var edgeset = [];
  
  nodeset[0] = {"id": 0, "label": root};
  for (i = 0; i < stringdata.length; i++) {
    var obj = {};
    obj["id"] = i+1;
    obj["label"] = stringdata[i];
    nodeset[i+1] = obj;
  }
  
  for (i = 1; i <= stringdata.length; i++) {
    var obj = {};
    obj["from"] = 0;
    obj["to"] = i;
    edgeset[i-1] = obj;
  }
  // datasets
  var nodes = new vis.DataSet(nodeset);
  var edges = new vis.DataSet(edgeset);

  // create network
  var container = document.getElementById("network");

  // provide the data
  var data = {
      nodes: nodes,
      edges: edges
  };
  var options = {
      interaction: {
          hover: true,
          tooltipDelay: 0},
      nodes: {
          shape: "box",
          color: {
              border: "#0C8D93",
              background: "#76CCD0",
              highlight: {
                  border: "#F3AA13",
                  background: "#FFCD65"
              },
              hover: {
                  border: "#F3AA13",
                  background: "#FFCD65"
              }
          }
      } 
  };

  // initialize the network
  var network = new vis.Network(container, data, options);
  return network;
}

// function used to scroll to specific parts of page
$.fn.scrollView = function () {
  return this.each(function () {
    $("html, body").animate({
      scrollTop: $(this).offset().top
    }, 500);
  });
}

$(document).ready(function() { 
  // simulate click on initial position button
  $("#btninitial").click();
  
  // hide left column content
  $("#network").hide();
  $("#pwordform").hide();
})

// click on position button
$("#positionletter").find("button").click(function(event){
  var position = event.target.id;
  // delete old 
  if ($("#allroots").length != "") {
      $("#allroots").remove();
  }
  // adapt styling
  $(event.target).removeClass("btn-outline-info").addClass("btn-info");
  $(event.target).siblings().removeClass("btn-info").addClass("btn-outline-info");
  
  // load radical letters
  $("#group").load("/tunico/getletters/".concat(position.substring(3)), function(rootresponse) {
    
    // click on radical
    $("#group").find("a").click(function(event) {
      var letter = $(event.target).text();
      $(event.target).addClass("bg-primary").addClass("text-white");
      $(event.target).siblings().removeClass("bg-primary").removeClass("text-white");
      
      // load roots
      $.get("/tunico/getroots/".concat(letter, "/", position.substring(3)), function(rootresponse) {
        if ($("#allroots").length != "") {
          $("#allroots").remove();
        }
        $("#leftcol").prepend(rootresponse);
        
        // click on root
        $("#allroots").find("a").click(function(netwevent){
          var root = $(netwevent.target).text();
          $(netwevent.target).addClass("bg-secondary");
          $(netwevent.target).siblings().removeClass("bg-secondary");
          $("#network").show();
          $("#pwordform").show();
          $("#lexical").empty();
          $("#terminformation").empty();
          $("#translations").empty();
          $("#externallinks").remove();
          
          // get relatives of root and draw network
          $.get("/tunico/root/".concat(root), function(response) {
            var network = createNetwork(root, response);
            network.body.nodes[0].options.color.background = "#ffffff";
            network.body.nodes[0].options.title = "root";
            $("#pwordform").scrollView();
            
            // click on network visualization
            network.on("click", function(params) {
              var selectednode = network.getSelectedNodes();
              if (selectednode.length != 0) {
                var label = network.body.nodes[selectednode].options.label;
                $("#lexical").empty();
                $("#terminformation").empty();
                $("#translations").empty();
                $("#externallinks").remove();
                
                // get all translations for specific node and set the title accordingly
                $.get("/tunico/translation/".concat(label), function(translation) {
                  network.body.nodes[selectednode].options.title = translation; 
                  network.interactionHandler._checkShowPopup(params.pointer.DOM);
                    
                    // get the english translation of the node
                    $.get("/tunico/engltransl/".concat(label, "/", root), function(answer) {
                      // dbtranslationdiv on left side, addinfodiv on right side
                      dbtranslationdiv = $("<div class='col-6'></div>");
                      addinfodiv = $("<div class='col-6 text-right mt-2'></div>");
                      
                      // get information on term from database
                      $.get("/tunico/terminformation/".concat(label, "/", root), function(terminfo) {
                        // append information on word form below network
                        h2 = $("<h2></h2>").text(terminfo[0]);
                        dbtranslationdiv.append(h2);
                        dbtranslationdiv.append($("<h3></h3>").text("English translations from database"));
                        // generate list for all translations from database
                        ultransl = ($("<ul id='ultransl'></ul>"));
                        for (var i = 0; i < answer.length; i++) {
                          litransl = $("<li></li>").text(answer[i]);
                          ultransl.append(litransl);
                        }
                        dbtranslationdiv.append(ultransl);
                        // check if information on etymology, pos and subc exists
                        if (terminfo[1]["etym"][0][0]) {
                          petym = $("<p></p>").text("ETYM: " + terminfo[1]["etym"][0][0] 
                                                    + " " + terminfo[1]["etym"][1] + " " + terminfo[1]["etym"][2]);
                        }
                        else {
                          petym = $("<p></p>").text("ETYM: -");
                        }
                        if (terminfo[1]["pos"][0]) {
                          ppos = $("<p></p>").text("POS: " + terminfo[1]["pos"][0]);
                        }
                        else {
                          ppos = $("<p></p>").text("POS: -");
                        }
                        if (terminfo[1]["subc"][0]) {
                          psubc = $("<p></p>").text("SUBC: " + terminfo[1]["subc"][0]);
                        }
                        else {
                          psubc = $("<p></p>").text("SUBC: -");
                        }
                        externlink = $("<a>Link to main project</a>");
                        externlink.attr("href", "https://tunico.acdh.oeaw.ac.at/dictionary.html?query=" + label);
                        addinfodiv.append($("<h4></h4>").text("Additional information"), petym, ppos, psubc, externlink);
                        $("#terminformation").append(dbtranslationdiv);
                        $("#terminformation").append(addinfodiv);
                        // no translation found in database
                        if (answer.length == 0) {
                          $("#lexical").empty();
                          $("#ultransl").empty();
                          $("#translations").empty();
                          $("#externallinks").remove();
                          dbtranslationdiv.append("<p>None found.<p>");
                        }
                        // translation found in database: use first translation
                        else {
                          // case: translation is dash
                          if (answer[0] == ("-")) {
                            
                          }
                          // case: translation is one word
                          else if (!answer[0].includes(" ")) {
                            loadDefinitions(answer[0]);
                          }
                          // case: translation are two or more words                       
                          else {
                            // case: only verbs like 'to go' are looked up 
                            if (answer[0].includes("to ")) {
                              var splitted = answer[0].split(" ");
                              if (splitted.length == 2) {
                                loadDefinitions(splitted[1]);
                              }
                            } 
                          }
                        }
                    });
                  });
                }); 
              }  
            });
          });  
        });
      });
    });
  });
});

// load definitions and translations from OmegaWiki
function loadDefinitions(term) {
  $("#lexical").load("/tunico/omegadefinition/".concat(term), function() {
    $("#lexical").scrollView();
    $.get("/tunico/lexvo/".concat(term), function(lexvo) {
        $("#lexical").before(lexvo);
      });
      
    // click on translation link of definition 
    $("#definitions").find("a").click(function(defevent){
      // prevent scrolling to top of page
      defevent.preventDefault();
      defevent.stopPropagation();
      // adapt styling
      $(defevent.target).parent().addClass("bg-info");
      $(defevent.target).parent().siblings().removeClass("bg-info");
      var dmid = defevent.target.id;
      // append div if it doesn't exist
      if ($("#translations").length == 0) {
        $("#lexical").append("<div id='translations'></div>");
      }
      // get translations from OmegaWiki
      $("#translations").load("/tunico/omegatransl/".concat(dmid), function() {
      });
      // scroll automatically down
      $("#translations").scrollView();
    });
  });
}