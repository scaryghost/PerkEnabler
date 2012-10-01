class MidGamePerks extends KFGui.KFTab_MidGamePerks;

function ShowPanel(bool bShow) {
    super.ShowPanel(bShow);

    if (bShow) {
        if (PlayerOwner() != none) {
            KFStatsAndAchievements = KFSteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements);
            lb_PerkSelect.List.InitList(KFStatsAndAchievements);
            lb_PerkProgress.List.InitList();
        }

        InitGRI();
    }
}

function OnPerkSelected(GUIComponent Sender) {
    lb_PerkEffects.SetContent(class'KFGameType'.default.LoadedSkills[lb_PerkSelect.GetIndex()]
        .default.LevelEffects[KFPlayerReplicationInfo(PlayerOwner().PlayerReplicationInfo).ClientVeteranSkillLevel]);
    lb_PerkProgress.List.PerkChanged(KFStatsAndAchievements, lb_PerkSelect.GetIndex());
}

function bool OnSaveButtonClicked(GUIComponent Sender) {
    local PlayerController PC;

    PC= Sender.PlayerOwner();
    if (KFPlayerController(PC) != none ) {
        PC.ConsoleCommand("mutate"@lb_PerkSelect.GetIndex());
    }
    else {
        class'KFPlayerController'.static.StaticSaveConfig();
    }

    return true;
}

defaultproperties {
    Begin Object Class=PerkSelectListBox Name=PerkSelectListBox
        OnCreateComponent=PerkSelectListBox.InternalOnCreateComponent
        WinTop=0.057760
        WinLeft=0.029240
        WinWidth=0.437166
        WinHeight=0.742836
    End Object
    lb_PerkSelect=PerkSelectListBox'PerkEnabler.MidGamePerks.PerkSelectListBox'
}
