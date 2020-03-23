//About: Resets have to be done manually when the IGT is static - in the Main Menu
//After starting, livesplit will keep track of the IGT all the time, it works everytime
//in the run, e.g. if you forget to start the timer, and you start it later in the run ~this may happen if you don't allow the script to start runs~
//it will still be accurate because it runs by IGT of the game itself.

//Setup: Edit Layout: + > Control > Scriptable Auto Splitter, browse for the script file
//Have fun and accurate timing c:

state("DeSmuME_0.9.11_x64")
{
    uint IGT : "DeSmuME_0.9.11_x64.exe", 0x558A150;
	byte bossHP : "DeSmuME_0.9.11_x64.exe", 0x216A3A2;
	byte room : "DeSmuME_0.9.11_x64.exe", 0x551CCB0;
}

state("DeSmuME_0.9.11_x86")
{
    uint IGT : "DeSmuME_0.9.11_x86.exe", 0x3019DB8;
	byte bossHP : "DeSmuME_0.9.11_x86.exe", 0x300B25A;
	byte room : "DeSmuME_0.9.11_x86.exe", 0x2FAC918;
}

state("MZZXLC"){
    uint IGT : "MZZXLC.exe", 0x2784CB8;
	byte room : "MZZXLC.exe", 0x278526C;
}

startup{
	refreshRate = 60;
	settings.Add("everyRoom", true, "Every Room");
	settings.SetToolTip("everyRoom", "Split when the game changes room ID. This will override every other option.");
	settings.Add("Intro", true, "Intro");
	settings.SetToolTip("Intro", "Split after intro stage.");
	settings.Add("Buckfire", true, "Buckfire");
	settings.SetToolTip("Buckfire", "Split after Buckfire stage.");
	settings.Add("RoseForce", true, "Rosepark and Chronoforce");
	settings.SetToolTip("RoseForce", "Split after Rosepark and Chronoforce stages, 2 splits.");
	settings.Add("Atlas", true, "Atlas");
	settings.SetToolTip("Atlas", "Split when you leave the Raiders Base.");
	settings.Add("Aelous", true, "Aelous");
	settings.SetToolTip("Aelous", "Split when you leave Aelous stage.");
	settings.Add("Thetis", true, "Thetis");
	settings.SetToolTip("Thetis", "Split when you leave Thetis stage.");
	settings.Add("Vulturon", true, "Vulturon");
	settings.SetToolTip("Vulturon", "Split when you leave Vulturon stage.");
	settings.Add("Queenbee", true, "Queenbee");
	settings.SetToolTip("Queenbee", "Split when you leave Queenbee stage.");
	settings.Add("BAV", true, "Before Aile/Vent");
	settings.SetToolTip("BAV", "Split before Aile/Vent.");
	settings.Add("AAV", true, "After Aile/Vent");
	settings.SetToolTip("AAV", "Split after Aile/Vent.");
	settings.Add("AUH", true, "Argoyle/Ugoyle and Hedgeshock splits");
	settings.SetToolTip("AUH", "Split after Argoyle/Ugoyle and Hedgeshock stages, 2 splits.");
	settings.Add("Bifrost", true, "Bifrost");
	settings.SetToolTip("Bifrost", "Split when you leave Bifrost stage.");
	settings.Add("PandP", true, "Pandora and Prometheus");
	settings.SetToolTip("PandP", "Hm");
}
 
start{
	if(current.IGT != old.IGT && (current.room == 5 || current.room == 1)){
		return true ;
	}
}
 
split{
	if(!settings["everyRoom"]){
		if(old.room == 2 && current.room == 10 && settings["Intro"]){
			//intro grey
			return true;
		}
		if(old.room == 5 && current.room == 10 && settings["Intro"]){
			//intro Ashe
			return true;
		}
		if(old.room == 7 && current.room == 6 && settings["Buckfire"]){
			//Buckfire
			return true;
		}
		if(old.room == 18 || old.room == 17 && settings["RoseForce"]){
			//Rosepark > Chronoforce
			if(current.room == 14 || current.room == 22){
				return true;
			}
		}
		if(old.room == 24 && current.room == 6 && settings["Atlas"]){
			// Atlas
			return true;
		}
		if(old.room == 28 || old.room == 41 || old.room == 37 || old.room == 45 || old.room == 33){
			//Sianarq
			if(current.room == 38 && old.room != 41 && settings["Aelous"]){
				// Aelous
				return true;
			}
			if(current.room == 34 && old.room != 37 && settings["Thetis"]){
				// Thetis
				return true;
			}
			if(current.room == 42 && old.room != 45 && settings["Vulturon"]){
				// Vulturon
				return true;
			}
			if(current.room == 30 && old.room != 33 && settings["Queenbee"]){
				// Queenbee
				return true;
			}
		}
		if(old.room == 41 || old.room == 37 || old.room == 45 || old.room == 33){
			if(current.room == 10 && settings["BAV"]){
				//Before Aile/Vent split
				return true;
			}
		}
		if(old.room == 49 && current.room == 10 && settings["AAV"]){
			// After Aile/Vent
			return true;
		}
		if(old.room == 53 || old.room == 4){
			if(current.room == 50 && settings["AUH"]){
				// Argoyle Ugoyle / Hedgeshock
				return true;		
			}
			if(current.room == 6 && settings["AUH"]){
				// Argoyle Ugoyle / Hedgeshock
				return true;		
			}
		}
		if(old.room == 56 && current.room == 6 && settings["Bifrost"]){
			// Bifrost
			return true;
		}
		if(old.room == 56 && current.room == 58 && settings["PandP"]){
			// Prometheus and Pandora
			return true;
		}
		if(old.room == 61 && current.room == 10 && settings["PandP"]){
			// Prometheus and Pandora
			return true;
		}
		if(old.room == 63 && current.room == 64 && settings["PandP"]){
			// Prometheus and Pandora
			return true;
		}
	}
	if(old.room != current.room && settings["everyRoom"]){
		return true;
	}
}
 
gameTime{
    return TimeSpan.FromSeconds(current.IGT / 60.0); 
}

//created by Flameberger and Ikkisoad
//Special Thx to Fatalis, blastedt and DrTchops.
//Comments from Ikkisoad