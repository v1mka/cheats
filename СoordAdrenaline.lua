script_author 'v1m'

local memory = require 'memory'
local imgui = require 'imgui'
local encoding = require 'encoding'
local inicfg = require 'inicfg'
require 'moonloader'

encoding.default = 'CP1251'
local u8 = encoding.UTF8

local resx, resy = getScreenResolution()

local window = imgui.ImBool(false)

local global_scale = 1.2


function apply_custom_style()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
		style.WindowRounding = 4.0
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
	style.ChildWindowRounding = 2.0
	style.FrameRounding = 2.0
	style.ItemSpacing = imgui.ImVec2(8.0*global_scale, 4.0*global_scale)
	style.ScrollbarSize = 15.0*global_scale
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8.0*global_scale
	style.GrabRounding = 1.0
	style.WindowPadding = imgui.ImVec2(8.0*global_scale, 8.0*global_scale)
	style.FramePadding = imgui.ImVec2(4.0*global_scale, 3.0*global_scale)
	style.DisplayWindowPadding = imgui.ImVec2(22.0*global_scale, 22.0*global_scale)
	style.DisplaySafeAreaPadding = imgui.ImVec2(4.0*global_scale, 4.0*global_scale)
	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.00, 0.00, 0.03, 0.85)
	colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
	colors[clr.PopupBg]                = ImVec4(0.00, 0.00, 0.03, 0.85)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg]                = ImVec4(0.4, 0.1, 0.9, 0.5)
	colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
	colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.TitleBg]                = ImVec4(0.441, 0.1, 0.6, 1.00)
	colors[clr.TitleBgActive]          = ImVec4(0.541, 0.169, 0.886, 1.00)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.MenuBarBg]              = ImVec4(0.1, 0.15, 0.3, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.06, 0.8)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.37, 0.51, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.47, 0.61, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.57, 0.71, 1.00)
	colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.4, 0.1, 0.88, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.5, 0.15, 0.98, 1.00)
	colors[clr.Button]                 = ImVec4(0.45, 0.1, 0.88, 0.40)
	colors[clr.ButtonHovered]          = ImVec4(0.5, 0.15, 0.9, 1.00)
	colors[clr.ButtonActive]           = ImVec4(0.5, 0.15, 0.9, 1.00)
	colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
	colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
	colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.Separator]              = colors[clr.Border]
	colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
	colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
	colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
	colors[clr.CloseButton]            = ImVec4(0.3, 0.05, 0.7, 0.8)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
	colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
	imgui.GetIO().Fonts:Clear()
	--imgui.GetStyle():ScaleAllSizes(global_scale)
	glyph_ranges_cyrillic = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
	imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 14*global_scale, nil, glyph_ranges_cyrillic)
	imgui.RebuildFonts()
end
apply_custom_style()

local settings = {
	main = {
		delta = 5,
		time = 1000,
		height = -10
	}
}

if not doesFileExist('moonloader/config/coradr.ini') then
	inicfg.save(settings, 'coradr.ini')
end

settings = inicfg.load(settings, 'coradr.ini')
inicfg.save(settings, 'coradr.ini')

local inputTime = imgui.ImInt(settings.main.time)
local inputDelta = imgui.ImInt(settings.main.delta)
local inputHeight = imgui.ImInt(settings.main.height)

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampRegisterChatCommand('ca', ca)
	imgui.ShowCursor = false
	imgui.Process = true
	wait(-1)
end

function imgui.OnDrawFrame()
	imgui.ShowCursor = false
	if window.v then
		window_f()
	end
end

function window_f()
	imgui.ShowCursor = true
	imgui.SetNextWindowPos(imgui.ImVec2(resx/2, resy/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5)) 
	imgui.SetNextWindowSize(imgui.ImVec2(260*global_scale, 170*global_scale)) 
	imgui.Begin('CoordAdrenaline', window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
	if imgui.Button('Ammo LS') then
		cordtp(1361.6196, -1277.6310, 13.3828, inputDelta.v, inputTime.v)
	end
	imgui.SameLine()
	if imgui.Button(u8'Мэрия') then
		cordtp(1482.3246, -1689.4470, 14.0772, inputDelta.v, inputTime.v)
	end
	imgui.SameLine()
	if imgui.Button(u8'Grove St.') then
		cordtp(2494.6782, -1670.1847, 13.3359, inputDelta.v, inputTime.v)
	end
	imgui.SameLine()
	if imgui.Button(u8'LSPD') then
		cordtp(1569.4573, -1704.0730, 5.8906, inputDelta.v, inputTime.v)
	end
	if imgui.Button(u8'Телепорт на метку', imgui.ImVec2(-1, 0)) then
		if getTargetBlipCoordinates() then
			local _, x, y, z = getTargetBlipCoordinates()
			cordtp(x, y, z, inputDelta.v, inputTime.v)
		end
	end
	imgui.SliderInt(u8'Расстояние', inputDelta, 5, 20)
	imgui.SliderInt(u8'Задержка', inputTime, 1000, 5000)
	imgui.SliderInt(u8'Высота', inputHeight, -30, 0)
	if imgui.Button(u8'Сохранить изменения', imgui.ImVec2(-1, 0)) then
		settings.main.time = inputTime.v
		settings.main.delta = inputDelta.v
		settings.main.height = inputHeight.v
		inicfg.save(settings, 'coradr.ini')
		printStringNow('SAVED', 2000)
	end
	imgui.End()
end

function ca()
	window.v = true
end

function cordtp(x, y, z, delta, time)
	lua_thread.create(function ()
		freezeCharPosition(PLAYER_PED, true)
		local myx, myy, myz = getCharCoordinates(PLAYER_PED)
		local angle = getHeadingFromVector2d(x - myx, y - myy)
		while math.abs(myz - inputHeight.v) > delta do
			if inputHeight.v > myz then
				setCharCoordinates(PLAYER_PED, myx, myy, myz-1+delta)
			else
				setCharCoordinates(PLAYER_PED, myx, myy, myz-1-delta)
			end
			myx, myy, myz = getCharCoordinates(PLAYER_PED)
			wait(time)
		end
		setCharCoordinates(PLAYER_PED, myx, myy, inputHeight.v)
		while getDistanceBetweenCoords2d(x, y, myx, myy) > delta do
			setCharCoordinates(PLAYER_PED, myx - delta*math.sin(math.rad(angle)), myy + delta*math.cos(math.rad(angle)), myz-1)
			myx, myy, myz = getCharCoordinates(PLAYER_PED)
			angle = getHeadingFromVector2d(x - myx, y - myy)
			wait(time)
		end
		while math.abs(myz - z) > delta do
			if z > myz then
				setCharCoordinates(PLAYER_PED, myx, myy, myz-1+delta)
			else
				setCharCoordinates(PLAYER_PED, myx, myy, myz-1-delta)
			end
			myx, myy, myz = getCharCoordinates(PLAYER_PED)
			--angle = getHeadingFromVector2d(x - myx, y - myy)
			wait(time)
		end
		setCharCoordinates(PLAYER_PED, x, y, z)
		freezeCharPosition(PLAYER_PED, false)
	end)
end
