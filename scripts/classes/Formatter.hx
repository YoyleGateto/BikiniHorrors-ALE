package;

import haxe.Xml;

class Formatter {
	public static function getCharacterData(Name:String)
	{
		if (Paths.exists("data/characters/" + Name + ".json")) {
			return Paths.json("data/characters/" + Name);
		} else if (Paths.exists("data/characters/" + Name + ".xml"))
			return codenameCharToPsych(Xml.parse(Paths.getContent("data/characters/" + Name + ".xml")));
		else
			return {};
	}
	
	public static function getStageData(Name:String)
	{
		var data = {}
		if (Paths.exists("data/stages/" + Name + ".json")) {
			data = Paths.json("data/stages/" + Name);
		} else if (Paths.exists("data/stages/" + Name + ".xml"))
			data = codenameStageToALE(Xml.parse(Paths.getContent("data/stages/" + Name + ".xml")));
		return data;
	}
	
    public static function codenameStageToALE(xml:Xml) {
        var stage = xml.firstElement();
		var path = stage.exists("folder") ? stage.get("folder") : "";//"
        var zoom = stage.exists("zoom") ? Std.parseFloat(stage.get("zoom")) : 1;
        
        var data = {
        	charactersOffset: {
        		type: {}
			},
            spritesConfig: {
            	directory: path,
            	sprites: []
			},
            zoom: zoom,
            speed: 1,
            hud: "default",//"
            format: "ale-stage-v0.1",//"
        };

		for (obj in stage.elements()) {
			if (obj != null) {
				var objData = {
					properties: {},
					animations: [],
					addMethod: "add"//"
				}
				debugTrace(obj);
				switch(obj.nodeName) {
					case "sprite":
						objData.id = obj.exists("name") ? obj.get("name") : ("obj_" + Std.string(index));
						objData.type = "image";
						objData.images = [obj.exists("sprite") ? obj.get("sprite") : ("")];
						objData.properties.x = obj.exists("x") ? Std.parseFloat(obj.get("x")) : 0.0;
						objData.properties.y = obj.exists("y") ? Std.parseFloat(obj.get("y")) : 0.0;
						if (obj.exists("scale")) {
							objData.properties.scale = {
								x: Std.parseFloat(obj.get("scale")),
								y: Std.parseFloat(obj.get("scale"))
							};
						}
						if (obj.exists("scalex")) {
							objData.properties.scale ??= {};
							objData.properties.scale.x = Std.parseFloat(obj.get("scalex"));
						}
						if (obj.exists("scaley")) {
							objData.properties.scale ??= {};
							objData.properties.scale.y = Std.parseFloat(obj.get("scaley"));
						}
						if (obj.exists("scroll")) {
							objData.properties.scrollFactor = {
								x: Std.parseFloat(obj.get("scroll")),
								y: Std.parseFloat(obj.get("scroll"))
							};
						}
						if (obj.exists("scrollx")) {
							objData.properties.scrollFactor ??= {};
							objData.properties.scrollFactor.x = Std.parseFloat(obj.get("scrollx"));
						}
						if (obj.exists("scrolly")) {
							objData.properties.scrollFactor ??= {};
							objData.properties.scrollFactor.y = Std.parseFloat(obj.get("scrolly"));
						}
						if (obj.exists("alpha")) {
							objData.properties.alpha = Std.parseFloat(obj.get("alpha"));
						}
						if (obj.exists("antialiasing")) {
							objData.properties.antialiasing = obj.get("antialiasing") == "true";
						}
						if (obj.exists("skew")) {
							objData.properties.skew = {
								x: Std.parseFloat(obj.get("skew")),
								y: Std.parseFloat(obj.get("skew"))
							};
						}
						if (obj.exists("skewx")) {
							objData.properties.skew ??= {};
							objData.properties.skew.x = Std.parseFloat(obj.get("skewx"));
						}
						if (obj.exists("skewy")) {
							objData.properties.skew ??= {};
							objData.properties.skew.y = Std.parseFloat(obj.get("skewy"));
						}
				        for (animNode in obj.elementsNamed("anim")) {
							objData.type = "atlas";
				            var name = animNode.exists("name") ? animNode.get("name") : "";
				            var prefix = animNode.exists("anim") ? animNode.get("anim") : "";//"
				            var fps = animNode.exists("fps") ? Std.parseInt(animNode.get("fps")) : 24;
				            var loop = animNode.exists("loop") ? (animNode.get("loop") == "true") : false;
				            var pos = [animNode.exists("x") ? Std.parseFloat(animNode.get("x")) : 0.0, animNode.exists("y") ? Std.parseFloat(animNode.get("y")) : 0.0];
							var indices = [];
							
				            if (animNode.exists("indices")) {
				                var strIndices = animNode.get("indices").split(",");
				                for (idx in strIndices) {
				                    var v = Std.parseInt(idx);
				                    if (v != null) indices.push(v);
				                }
				            }
				
				            var anim = {
				            	indices: indices,
				                loop: loop,
				                fps: fps,
				                offsets: pos,
				                name: name,
				                prefix: prefix
				            };
				            objData.animations.push(anim);
				        }
						data.spritesConfig.sprites.push(objData);
					case "box":
						objData.id = obj.exists("name") ? obj.get("name") : ("obj_" + Std.string(index));
						objData.type = "box";
						objData.width = obj.exists("width") ? Std.parseInt(obj.get("width")) : 1;
						objData.height = obj.exists("height") ? Std.parseInt(obj.get("height")) : 1;
						objData.properties.x = obj.exists("x") ? Std.parseFloat(obj.get("x")) : 0.0;
						objData.properties.y = obj.exists("y") ? Std.parseFloat(obj.get("y")) : 0.0;
						if (obj.exists("scale")) {
							objData.properties.scale = {
								x: Std.parseFloat(obj.get("scale")),
								y: Std.parseFloat(obj.get("scale"))
							};
						}
						if (obj.exists("scalex")) {
							objData.properties.scale ??= {};
							objData.properties.scale.x = Std.parseFloat(obj.get("scalex"));
						}
						if (obj.exists("scaley")) {
							objData.properties.scale ??= {};
							objData.properties.scale.y = Std.parseFloat(obj.get("scaley"));
						}
						if (obj.exists("scroll")) {
							objData.properties.scrollFactor = {
								x: Std.parseFloat(obj.get("scroll")),
								y: Std.parseFloat(obj.get("scroll"))
							};
						}
						if (obj.exists("scrollx")) {
							objData.properties.scrollFactor ??= {};
							objData.properties.scrollFactor.x = Std.parseFloat(obj.get("scrollx"));
						}
						if (obj.exists("scrolly")) {
							objData.properties.scrollFactor ??= {};
							objData.properties.scrollFactor.y = Std.parseFloat(obj.get("scrolly"));
						}
						if (obj.exists("alpha")) {
							objData.properties.alpha = Std.parseFloat(obj.get("alpha"));
						}
						if (obj.exists("antialiasing")) {
							objData.properties.antialiasing = obj.get("antialiasing") == "true";
						}
						if (obj.exists("skew")) {
							objData.properties.skew = {
								x: Std.parseFloat(obj.get("skew")),
								y: Std.parseFloat(obj.get("skew"))
							};
						}
						if (obj.exists("skewx")) {
							objData.properties.skew ??= {};
							objData.properties.skew.x = Std.parseFloat(obj.get("skewx"));
						}
						if (obj.exists("skewy")) {
							objData.properties.skew ??= {};
							objData.properties.skew.y = Std.parseFloat(obj.get("skewy"));
						}
						data.spritesConfig.sprites.push(objData);
					case "bf":
						data.charactersOffset.type.player = {
							x: obj.exists("x") ? Std.parseFloat(obj.get("x")) : 0.0,
							y: obj.exists("y") ? Std.parseFloat(obj.get("y")) : 0.0
						};
					case "gf":
						data.charactersOffset.type.extra = {
							x: obj.exists("x") ? Std.parseFloat(obj.get("x")) : 0.0,
							y: obj.exists("y") ? Std.parseFloat(obj.get("y")) : 0.0
						};
					case "dad":
						data.charactersOffset.type.opponent = {
							x: obj.exists("x") ? Std.parseFloat(obj.get("x")) : 0.0,
							y: obj.exists("y") ? Std.parseFloat(obj.get("y")) : 0.0
						};
				}
			}
		}
        return data;
    }
    
    public static function codenameCharToPsych(xml:Xml) {
        var char = xml.firstElement();
		var sprite = char.exists("sprite") ? ("characters/" + char.get("sprite")) : "characters/bf";
        var scaleStr = char.exists("scale") ? char.get("scale") : "1";
        var scale = Std.parseFloat(scaleStr);
        if (scale == null || scale == 0) scale = 1.0;

        var icon = char.exists("icon") ? char.get("icon") : "face";//"
        
        var pos = [char.exists("x") ? Std.parseFloat(char.get("x")) : 0.0, char.exists("y") ? Std.parseFloat(char.get("y")) : 0.0];
        var camPos = [char.exists("camx") ? Std.parseFloat(char.get("camx")) : 0.0, char.exists("camy") ? Std.parseFloat(char.get("camy")) : 0.0];

        var flipX = char.exists("flipX") ? (char.get("flipX") == "true") : false;
        var aliased = char.exists("antialiasing") ? (char.get("antialiasing") == "false") : false;
        var color = char.exists("color") ? char.get("color") : "#CDCDCD";
        var singLength = char.exists("holdTime") ? char.get("holdTime") : 4.0;

        var data = {
            animations: [],
            image: sprite,
            scale: scale,
            sing_duration: singLength,
            healthicon: icon,
            position: pos,
            camera_position: camPos,
            flip_x: flipX,
            no_antialiasing: aliased,
            healthbar_colors: convertHexColor(color)
        };

        for (animNode in char.elementsNamed("anim")) {
            var name = animNode.exists("name") ? animNode.get("name") : "";
            var prefix = animNode.exists("anim") ? animNode.get("anim") : "";//"
            var fps = animNode.exists("fps") ? Std.parseInt(animNode.get("fps")) : 24;
            var loop = animNode.exists("loop") ? (animNode.get("loop") == "true") : false;
            var pos = [animNode.exists("x") ? Std.parseFloat(animNode.get("x")) : 0.0, animNode.exists("y") ? Std.parseFloat(animNode.get("y")) : 0.0];
			var indices = [];
			
            if (animNode.exists("indices")) {
                var strIndices = animNode.get("indices").split(",");
                for (idx in strIndices) {
                    var v = Std.parseInt(idx);
                    if (v != null) indices.push(v);
                }
            }

            var anim = {
            	indices: indices,
                loop: loop,
                fps: fps,
                offsets: pos,
                anim: name,
                name: prefix
            };
            data.animations.push(anim);
        }

        return data;
    }
        		
    static function convertHexColor(hexStr:String):Array<Int> {
        if (hexStr == null || hexStr == "") return [161, 161, 161];
        
        hexStr = StringTools.replace(hexStr, "#", "");
        hexStr = StringTools.replace(hexStr, "0x", "");
        var color:Null<Int> = Std.parseInt("0x" + hexStr);
        if (color == null) return [161, 161, 161];
        
        var r = (color >> 16) & 0xFF;
        var g = (color >> 8) & 0xFF;
        var b = color & 0xFF;
        
        return [r, g, b];
    }
}
