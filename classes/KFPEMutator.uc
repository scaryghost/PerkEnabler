class KFPEMutator extends Mutator;

function PostBeginPlay() {
    DeathMatch(Level.Game).LoginMenuClass= "KFPerkEnabler.LoginMenu";
}

function bool CheckReplacement(Actor other, out byte bSuperRelevant) {
    if (KFPlayerController(Other) != none) {
        KFPlayerController(Other).LobbyMenuClassString= "KFPerkEnabler.LobbyMenu_KFPE";
    }
    return true;
}

defaultproperties {
    GroupName="KFPerkEnabler"
    FriendlyName="Perk Enabler v1.0"
    Description="Enables perk usage when offline or running non-whitelisted content"
}
