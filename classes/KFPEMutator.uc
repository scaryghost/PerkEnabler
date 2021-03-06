class KFPEMutator extends Mutator;

var() config int perkLevel;

function PostBeginPlay() {
    if (KFGameType(Level.Game) == none) {
        Destroy();
        return;
    }
    DeathMatch(Level.Game).LoginMenuClass= "PerkEnabler.LoginMenu";
    AddToPackageMap("PerkEnabler");
}

simulated function Tick(float DeltaTime) {
    local KFPlayerController PC;
 
    PC= KFPlayerController(Level.GetLocalPlayerController());
    if (PC != None) {
        PC.LobbyMenuClassString= "PerkEnabler.LobbyMenu_KFPE";
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
    if (!KFGameReplicationInfo(Level.GRI).bWaveInProgress || 
            KFGameReplicationInfo(Level.GRI).bWaveInProgress && !KFPlayerController(Sender).bChangedVeterancyThisWave) {
        KFPlayerReplicationInfo(Sender.PlayerReplicationInfo).ClientVeteranSkill= class'KFGameType'.default.LoadedSkills[int(command)];
        KFPlayerController(Sender).SelectedVeterancy= class'KFGameType'.default.LoadedSkills[int(command)];
        KFPlayerController(Sender).bChangedVeterancyThisWave= true;
        KFHumanPawn(Sender.Pawn).VeterancyChanged();
        Sender.SaveConfig();
    } else if (KFGameReplicationInfo(Level.GRI).bWaveInProgress) {
        Sender.ClientMessage("You can only change perks during trader time");
    } else {
        Sender.ClientMessage(KFPlayerController(Sender).PerkChangeOncePerWaveString);
    }
}

static function FillPlayInfo(PlayInfo PlayInfo) {
    Super.FillPlayInfo(PlayInfo);
    PlayInfo.AddSetting("PerkEnabler", "perkLevel", "Perk Level", 0, 0, "Text");
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
