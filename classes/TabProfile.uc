class TabProfile extends KFGui.KFTab_Profile;

function ShowPanel(bool bShow) {
    if (bShow) {
        if (bInit) {
            bRenderDude = True;
            bInit = False;
        }

        if (PlayerOwner() != none) {
            KFStatsAndAchievements = KFSteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements);
            lb_PerkSelect.List.InitList(KFStatsAndAchievements);
            lb_PerkProgress.List.InitList();
        }
    }

    lb_PerkSelect.SetPosition(i_BGPerks.WinLeft + 6.0 / float(Controller.ResX),
                              i_BGPerks.WinTop + 38.0 / float(Controller.ResY),
                              i_BGPerks.WinWidth - 10.0 / float(Controller.ResX),
                              i_BGPerks.WinHeight - 35.0 / float(Controller.ResY),
                              true);


    SetVisibility(bShow);
}

function SaveSettings() {
    local PlayerController PC;

    PC = PlayerOwner();

    if (sChar != sCharD)  {
        sCharD = sChar;
        PC.ConsoleCommand("ChangeCharacter"@sChar);

        if ( !PC.IsA('xPlayer') ) {
            PC.UpdateURL("Character", sChar, True);
        }

        if ( PlayerRec.Sex ~= "Female" ) {
            PC.UpdateURL("Sex", "F", True);
        }
        else {
            PC.UpdateURL("Sex", "M", True);
        }
    }

    if (KFPlayerController(PC) != none ) {
        PC.ConsoleCommand("mutate"@lb_PerkSelect.GetIndex());
    }
    else {
        class'KFPlayerController'.static.StaticSaveConfig();
    }
}

function OnPerkSelected(GUIComponent Sender) {
    lb_PerkEffects.SetContent(class'KFGameType'.default.LoadedSkills[lb_PerkSelect.GetIndex()].default.LevelEffects[KFPlayerReplicationInfo(PlayerOwner().PlayerReplicationInfo).ClientVeteranSkillLevel]);
    lb_PerkProgress.List.PerkChanged(KFStatsAndAchievements, lb_PerkSelect.GetIndex());
}

defaultproperties {
    Begin Object Class=PerkSelectListBox Name=PerkSelectListBox
        OnCreateComponent=PerkSelectListBox.InternalOnCreateComponent
        WinTop=0.082969
        WinLeft=0.323418
        WinWidth=0.318980
        WinHeight=0.654653
    End Object
    lb_PerkSelect=PerkSelectListBox'PerkEnabler.TabProfile.PerkSelectListBox'
}
