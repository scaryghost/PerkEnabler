class KFPEMutator extends Mutator;

function PostBeginPlay() {
    DeathMatch(Level.Game).LoginMenuClass= "KFPerkEnabler.LoginMenu";
}

defaultproperties {
    GroupName="KFPerkEnabler"
    FriendlyName="Perk Enabler v1.0"
    Description="Enables perk usage when offline or running non-whitelisted content"
}
