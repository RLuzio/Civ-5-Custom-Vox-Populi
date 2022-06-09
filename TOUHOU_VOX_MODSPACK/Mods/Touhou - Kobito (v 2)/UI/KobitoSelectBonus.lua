-- Shinmyoumaru bonus select popup

include("InstanceManager")
include("KobitoUtil.lua");

ContextPtr:SetHide(true);

local g_CSManager = InstanceManager:new("KobitoInstance", "KobitoLabel", Controls.KobitoStack);

local KobitoBonus = {
Locale.ConvertTextKey("TXT_KEY_KOBITO_BONUS_01"), 
Locale.ConvertTextKey("TXT_KEY_KOBITO_BONUS_02"),
Locale.ConvertTextKey("TXT_KEY_KOBITO_BONUS_03")
};

function KobitoFreeBonusImage ( instance, iLabel )
	if iLabel == 1 then
		instance.KobitoFreeImage:SetTexture("NotificationIconsFreeSocialPolicy.dds");
	elseif iLabel == 2 then
		instance.KobitoFreeImage:SetTexture("NotificationIconsFreeScience.dds");
	elseif iLabel == 3 then
		instance.KobitoFreeImage:SetTexture("NotificationIconsFreeGreatPerson.dds");
	else
		return;
	end
end

function UpdateKobitoBonusList()
	local pPlayer = Players[Game.GetActivePlayer()];
	Controls.KobitoStack:DestroyAllChildren();
	
	for i, v in ipairs(KobitoBonus) do
		local instance = g_CSManager:GetInstance();
		KobitoFreeBonusImage(instance,i);
		instance.KobitoLabel:SetText(v);

		if not KobitoCheckDummyBuilding(pPlayer,i) then
			instance.KobitoButton:RegisterCallback( Mouse.eLClick, function() LuaEvents.DisplayMessageEdit(Locale.ConvertTextKey("TXT_KEY_OPSCREEN_CONFIRM"), "", {}, {Locale.ConvertTextKey("TXT_KEY_POPUP_YES"), Locale.ConvertTextKey("TXT_KEY_POPUP_NO")}, {[Locale.ConvertTextKey("TXT_KEY_POPUP_YES")] = function() KobitoActivateBonus(i,pPlayer); ContextPtr:SetHide(true); end}) end )
			local KobitoToolTip = Locale.ConvertTextKey("TXT_KEY_KOBITO_SELECT_BONUS_TOOLTIP", v);
			local era = pPlayer:GetCurrentEra();
			era = era + 1;
			if GameInfo.Eras[era] ~= nil then
				local eraname = GameInfo.Eras[era].Description;
				KobitoToolTip = KobitoToolTip .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_KOBITO_SELECT_BONUS_TOOLTIP_INFO", eraname);
			end
			instance.KobitoButton:SetToolTipString(KobitoToolTip);
		else
			instance.KobitoButton:SetAlpha(0.5);
			local KobitoToolTip = Locale.ConvertTextKey("TXT_KEY_KOBITO_CANNOT_SELECT_BONUS");
			instance.KobitoButton:SetToolTipString(KobitoToolTip);
		end
	end

	Controls.KobitoStack:CalculateSize();
	Controls.KobitoStack:ReprocessAnchoring();
	Controls.KobitoPanel:CalculateInternalSize();
end

function OnShowHide( bHide, bInit )
	if not bHide then
		UpdateKobitoBonusList();
	end
end
ContextPtr:SetShowHideHandler( OnShowHide )

function PopUpKobito()
	ContextPtr:SetHide(false);
end
LuaEvents.PopUpKobito.Add( PopUpKobito );