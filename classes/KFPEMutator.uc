class KFPEMutator extends Mutator;

var() config int perkLevel;

function PostBeginPlay() {
    if (KFGameType(Level.Game) == none) {
        Destroy();
        return;
    }
    DeathMatch(Level.Game).LoginMenuClass= "KFPerkEnabler.LoginMenu";
    AddToPackageMap("KFPerkEnabler");
}

simulated function Tick(float DeltaTime) {
    local KFPlayerController PC;
 
    PC= KFPlayerController(Level.GetLocalPlayerController());
    if (PC != None) {
        PC.LobbyMenuClassString= "KFPerkEnabler.LobbyMenu_KFPE";
        PC.ClientCloseMenu(true, true);
        PC.ShowLobbyMenu();
    }
    Disable('Tick');    
}

function bool CheckReplacement(Actor other, out byte bSuperRelevant) {
    if (KFPlayerReplicationInfo(Other) != none) {
        KFPlayerReplicationInfo(Other).ClientVeteranSkillLevel= perkLevel;
    }
    return true;
}

function Mutate(string Command, PlayerController Sender) {
    if (KFGameReplicationInfo(Level.GRI).bWaveInProgress) {
        Sender.ClientMessage("You can only change perks during trader time");
    } else if (KFPlayerController(Sender).bChangedVeterancyThisWave) {
        Sender.ClientMessage(KFPlayerController(Sender).PerkChangeOncePerWaveString);
    } else {
        KFPlayerReplicationInfo(Sender.PlayerReplicationInfo).ClientVeteranSkill= class'KFGameType'.default.LoadedSkills[int(command)];
        KFPlayerController(Sender).bChangedVeterancyThisWave= true;
        KFHumanPawn(Sender.Pawn).VeterancyChanged();
        Sender.SaveConfig();
    }
}

static function FillPlayInfo(PlayInfo PlayInfo) {
    Super.FillPlayInfo(PlayInfo);
    PlayInfo.AddSetting("KFPerkEnabler", "perkLevel", "Perk Level", 0, 0, "Text");
}

static event string GetDescriptionText(string property) {
    switch(property) {
        case "perkLevel":
            return "Perk level of all players";
        default:
            return Super.GetDescriptionText(property);
    }
}

defaultproperties {
    perkLevel= 0

    GroupName="KFPerkEnabler"
    FriendlyName="Perk Enabler v1.0"
    Description="Enables perk usage when offline or running non-whitelisted content"

    RemoteRole=ROLE_SimulatedProxy
    bAlwaysRelevant=true
}
