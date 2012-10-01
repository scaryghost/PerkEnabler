class LoginMenu extends KFGui.KFInvasionLoginMenu;

function InitComponent(GUIController MyController, GUIComponent MyComponent) {
    Super(UT2K4PlayerLoginMenu).InitComponent(MyController, MyComponent);
    c_Main.RemoveTab(Panels[0].Caption);
    c_Main.ActivateTabByName(Panels[1].Caption, true);
}

defaultproperties {
    Panels(1)=(ClassName="PerkEnabler.MidGamePerks",Caption="Perks",Hint="Select your current Perk")
}
