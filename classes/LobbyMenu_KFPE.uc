class LobbyMenu_KFPE extends KFGui.LobbyMenu;

defaultproperties {
    Begin Object Class=LobbyFooter_KFPE Name=LobbyFooter
        RenderWeight=0.300000
        TabOrder=8
        bBoundToParent=False
        bScaleToParent=False
        OnPreDraw=LobbyFooter.InternalOnPreDraw
    End Object
    t_Footer=LobbyFooter_KFPE'KFPerkEnabler.LobbyMenu_KFPE.LobbyFooter'
}
