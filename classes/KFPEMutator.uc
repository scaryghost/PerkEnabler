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

function bool CheckReplacement(Actor other, out byte bSuperRelevant) {
    if (KFPlayerController(Other) != none) {
        KFPlayerController(Other).LobbyMenuClassString= "KFPerkEnabler.LobbyMenu_KFPE";
    } else if (KFPlayerReplicationInfo(Other) != none) {
        KFPlayerReplicationInfo(Other).ClientVeteranSkill= class'KFGameType'.default.LoadedSkills[rand(class'KFGameType'.default.LoadedSkills.Length)];
        KFPlayerReplicationInfo(Other).ClientVeteranSkillLevel= perkLevel;
    }
    return true;
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
