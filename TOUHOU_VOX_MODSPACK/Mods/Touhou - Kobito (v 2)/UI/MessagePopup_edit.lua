--[[
	MessagePopup.lua
	
	Creator: alpaca
	Last Change: 27.01.2011
	
	Description: 
	Creates an event to display a generic pop-up message with a title and a text. Copies a lot of code from GenericPopup.lua
]]--


--------------------------
--edit
--------------------------
ContextPtr:SetHide(true)
--------------------------




-- Shows popup window.
function ShowWindow()
	ResizeWindow();
	UIManager:QueuePopup( ContextPtr, PopupPriority.GenericPopup );
end

-- Hides popup window.
function HideWindow()
    UIManager:DequeuePopup( ContextPtr );
    ClearChildren();
end

function ResizeWindow()
    Controls.ButtonStack:CalculateSize();
	Controls.ButtonStackFrame:DoAutoSize();
end

function AddText(popupText)
	local instance = {}
	ContextPtr:BuildInstanceForControl("MessageLabelInstance", instance, Controls.ButtonStack)
	instance.MessageLabel:SetText(popupText)
	instance.MessageLabel:SetHide(false)
end

function SetPopupTitle(popupTitle)
	if popupTitle then
		Controls.PopupTitle:SetText(popupTitle);
		Controls.PopupTitle:SetHide(false);
	else
		Controls.PopupTitle:SetHide(true);
	end
end

function ClearChildren()
	Controls.ButtonStack:DestroyAllChildren();
	ResizeWindow();
end

-- Add a button to popup.
-- NOTE: Current Limitation is 4 buttons
function AddButton(buttonText, buttonClickFunc, strToolTip)
	local instance = {}
	ContextPtr:BuildInstanceForControl("MessageButtonInstance", instance, Controls.ButtonStack)
	local button = instance.MessageButton --Controls["Button"..i];
	
	if button then
		local buttonLabel = instance.MessageButtonText
		buttonLabel:SetText( buttonText );
		
		if strToolTip then
			button:SetToolTipString(strToolTip);
		end

		--By default, button clicks will hide the popup window after
		--executing the click function
		local clickHandler = function()
			if buttonClickFunc then
				buttonClickFunc();
			end
			
			HideWindow();
		end
		
		button:RegisterCallback(Mouse.eLClick, clickHandler);
		
		button:SetHide(false);
		
		return;
	end
end


function ShowHideHandler( bIsHide, bIsInit )
	if bIsInit or bIsHide then
		Controls.ButtonStackFrame:SetHide(true)
	else
		Controls.ButtonStackFrame:SetHide(false)
	end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );


--[[
	Displays a pop-up with a custom set-up.
	Arguments:
		fSetupFunction: function. Function that sets up all the buttons and texts itself
]]--
function DisplayPopup(fSetupFunction)
	fSetupFunction()
	ShowWindow()
end
LuaEvents.DisplayPopup.Add(DisplayPopup)


--[[
	Displays a pre-made message pop-up
	Arguments:
		sText: string. Text to display. Required
		sTitle: string. The title, will default to "Message"
		tButtons: table. A table containing the buttons you want to display. Table keys are what to put on the button label, values is a tooltip (use false if you don't want one). Optional use: string. Interpreted as text for a single button, in which case tButtonIDs is interpreted as an optional tooltip and tHandlers as a callback function
		tButtonIDs: table. A numeric table containing an ordered list of buttons if desired
		tHandlers: table. Click handler functions for the buttons. Must be indexed by the key
]]--
function DisplayMessageEdit(sText, sTitle, tButtons, tButtonIDs, tHandlers)
	ClearChildren()
	AddText(sText)
	SetPopupTitle(sTitle)
	if type(tButtons) == "table" then
		-- buttons are given
		if tButtonIDs then
		-- ordered list
			for _, buttonText in ipairs(tButtonIDs) do
				local handler
				if tHandlers then
					handler = tHandlers[buttonText] or nil
				end
				local tooltip = tButtons[buttonText] and tButtons[buttonText] or nil
				AddButton(tostring(buttonText), handler, tooltip)
			end
		else
		-- unordered list
			for buttonText, buttonTip in pairs(tButtons) do
				local handler
				if tHandlers then
					handler = tHandlers[buttonText] or nil
				end
				AddButton(tostring(buttonText), handler, buttonTip and tostring(buttonTip) or nil)
			end
		end
	elseif type(tButtons) == "string" then
		-- only one button, interpret as strings
		AddButton(tButtons, tHandlers, tostring(tButtonIDs))
	else
		AddButton(Locale.ConvertTextKey("TXT_KEY_CLOSE"))
	end
	ShowWindow()
end
LuaEvents.DisplayMessageEdit.Add(DisplayMessageEdit)