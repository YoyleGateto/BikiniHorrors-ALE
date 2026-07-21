import Formatter;
import haxe.io.Path;
import sys.io.File;

using StringTools;

for (file in Paths.readDirectory("data/characters", "unique"))
{
	if (file.endsWith(".xml"))
	{
		var data = Formatter.getCharacterData(Path.withoutExtension(file));
		File.saveContent(Paths.mods + "/" + Paths.mod + "/data/characters/" + Path.withoutExtension(file) + ".json", Json.stringify(data));
	}
}

for (file in Paths.readDirectory("data/stages", "unique"))
{
	if (file.endsWith(".xml"))
	{
		var data = Formatter.getStageData(Path.withoutExtension(file));
		File.saveContent(Paths.mods + "/" + Paths.mod + "/data/stages/" + Path.withoutExtension(file) + ".json", Json.stringify(data));
	}
}