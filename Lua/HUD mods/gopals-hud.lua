if (!CLIENT) then
  PrintMessage(HUD_PRINTCONSOLE, "[Gopal's HUD] Must be run clientside; exiting.")
  return
end

local ply = LocalPlayer()

ply:PrintMessage(HUD_PRINTCONSOLE, "[Gopal's HUD] Version: v1.0.0")
ply:PrintMessage(HUD_PRINTCONSOLE, "\n[Gopal's HUD] Starting init...")

local function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function DrawGopalsHUD()
  local color = Color(255, 220, 0, 100)
  local font = "TargetIDSmall"
  local posX = ScrW() * 0.5
  local posY = ScrH() * 0.5 + 50
  local pos2X = ScrW() * 0.5
  local pos2Y = ScrH() * 0.5 - 60
  draw.DrawText("AP: " .. ply:Armor(), font, pos2X, pos2Y, color, TEXT_ALIGN_CENTER)
  draw.DrawText("HP: " .. ply:Health(), font, pos2X, pos2Y - 20, color, TEXT_ALIGN_CENTER)
  draw.DrawText("N: " .. ply:GetName(), font, pos2X, pos2Y - 40, color, TEXT_ALIGN_CENTER)
  draw.DrawText("ID: " .. ply:SteamID(), font, pos2X, pos2Y - 60, color, TEXT_ALIGN_CENTER)
  local plyActiveWep = "N/A"
  local plyActiveWepC = "N/A"
  local plyActiveWepAmmo = ""
  if (ply["GetActiveWeapon"]) then
    local pActiveWep = ply:GetActiveWeapon()
    if (pActiveWep == NULL) then
      plyActiveWepAmmo = "N/A"
    else
      local plyPrintName = pActiveWep:GetPrintName()
      local plyPrintNameTranslated = language.GetPhrase(plyPrintName)
      if (plyPrintName == plyPrintNameTranslated) then
        plyActiveWep = plyPrintNameTranslated
      else
        plyActiveWep = plyPrintNameTranslated .. " (" .. plyPrintName .. ")"
      end
      plyActiveWepC = pActiveWep:GetClass()
      local pAmmoPType = pActiveWep:GetPrimaryAmmoType()
      local pAmmoSType = pActiveWep:GetSecondaryAmmoType()
      if (!(pAmmoPType == -1)) then
        plyActiveWepAmmo = "[P] " .. pAmmoPType .. ": " .. game.GetAmmoName(pAmmoPType) .. " (amt: " .. ply:GetAmmoCount(pAmmoPType) .. ")"
      end
      if (!(pAmmoSType == -1)) then
        if (!(pAmmoPType == -1)) then
          plyActiveWepAmmo = plyActiveWepAmmo .. " | "
        end
        plyActiveWepAmmo = plyActiveWepAmmo .. "[S] " .. plyActiveWepAmmo .. pAmmoSType .. ": " .. game.GetAmmoName(pAmmoSType) .. " (amt: " .. ply:GetAmmoCount(pAmmoSType) .. ")"
      end
    end
  end
  if (plyActiveWepAmmo == "") then
    plyActiveWepAmmo = "N/A"
  end
  local plyUsing = "N/A"
  if (!(ply:GetEntityInUse() == NULL)) then
    local plyUsingEnt = ply:GetEntityInUse()
    if (plyUsingEnt["GetName"]) then
      plyUsing = plyUsingEnt:GetName() .. " (" .. ply:GetEntityInUse():GetClass() .. ")"
    else
      plyUsing = plyUsingEnt:GetClass()
    end
  end
  draw.DrawText("Wep: " .. plyActiveWep .. " [" .. plyActiveWepC .. "]" .. " {" .. plyActiveWepAmmo .. "}", font, pos2X, pos2Y - 80, color, TEXT_ALIGN_CENTER)
  draw.DrawText("Using: " .. plyUsing, font, pos2X, pos2Y - 100, color, TEXT_ALIGN_CENTER)
  local plyVel = ply:GetVelocity()
  local plyPos = ply:GetPos()
  local plyAng = ply:GetAngles()
  draw.DrawText("Pos: (" .. tostring(round(plyPos[1])) .. ", " .. tostring(round(plyPos[2])) .. ", " .. tostring(round(plyPos[3])) .. ")", font, pos2X, pos2Y - 120, color, TEXT_ALIGN_CENTER)
  draw.DrawText("Ang: (" .. tostring(round(plyAng[1])) .. ", " .. tostring(round(plyAng[2])) .. ", " .. tostring(round(plyAng[3])) .. ")", font, pos2X, pos2Y - 140, color, TEXT_ALIGN_CENTER)
  draw.DrawText("Vel: " .. tostring(round(plyVel:Length())) .. " (" .. tostring(round(plyVel[1])) .. ", " .. tostring(round(plyVel[2])) .. ", " .. tostring(round(plyVel[3])) .. ")", font, pos2X, pos2Y - 160, color, TEXT_ALIGN_CENTER)
  local tr = ply:GetEyeTrace()
  local trEnt = tr.Entity
  if (!trEnt or trEnt:EntIndex() == 0) then
    draw.DrawText("(no target)", font, posX, posY, color, TEXT_ALIGN_CENTER)
    return
  end
  local entName = ""
  if (trEnt["GetName"]) then
    entName = trEnt:GetName()
  else
    entName = "N/A"
  end
  local entArmor = ""
  if (trEnt["Armor"]) then
    entArmor = trEnt:Armor()
  else
    entArmor = "N/A"
  end
  local entPos = trEnt:GetPos()
  local entAng = trEnt:GetAngles()
  local entWeaponCName = "N/A"
  local entWeaponName = "N/A"
  local entActiveWepAmmo = ""
  local entActiveWep = NULL
  if (trEnt["GetActiveWeapon"]) then
    entActiveWep = trEnt:GetActiveWeapon()
    if (entActiveWep == NULL) then
      entWeaponName = "None";
      entActiveWepAmmo = "N/A"
    else
      entWeaponCName = entActiveWep:GetClass()
      local printName = entActiveWep:GetPrintName()
      local printNameTranslated = language.GetPhrase(printName)
      if (printName == printNameTranslated) then
        entWeaponName = printNameTranslated
      else
        entWeaponName = printNameTranslated .. " (" .. printName .. ")"
      end

      local eAmmoPType = entActiveWep:GetPrimaryAmmoType()
      local eAmmoSType = entActiveWep:GetSecondaryAmmoType()
      if (!(eAmmoPType == -1)) then
        entActiveWepAmmo = "[P] " .. eAmmoPType .. ": " .. game.GetAmmoName(eAmmoPType) .. ""
      end
      if (!(eAmmoSType == -1)) then
        if (!(eAmmoPType == -1)) then
          entActiveWepAmmo = entActiveWepAmmo .. " | "
        end
        entActiveWepAmmo = entActiveWepAmmo .. "[S] " .. eAmmoSType .. ": " .. game.GetAmmoName(eAmmoSType) .. ""
      end
      LocalPlayer():PrintMessage(HUD_PRINTCONSOLE, "\nhi[" .. entActiveWepAmmo .. "]bye\n")
      if (entActiveWepAmmo == "") then
        entActiveWepAmmo = "N/A"
      end
    end
  end
  local entWeaponProficiency = "N/A"
  if (trEnt["GetCurrentWeaponProficiency"]) then
    print("yay")
    local wepProf = trEnt:GetCurrentWeaponProficiency()
    local wepProfVals = {
      [0] = "Poor",
      [1] = "Average",
      [2] = "Good",
      [3] = "Very Good",
      [4] = "Perfect"
    }
    if (wepProfVals[wepProf]) then
      entWeaponProficiency = wepProfVals[wepProf] .. " (" .. tostring(wepProf) .. ")"
    else
      entWeaponProficiency = "N/A (" .. tostring(wepProf) .. ")"
    end
  end
  draw.DrawText("CN: " .. trEnt:GetClass(), font, posX, posY, color, TEXT_ALIGN_CENTER)
  draw.DrawText("N: " .. entName, font, posX, posY + 20, color, TEXT_ALIGN_CENTER)
  draw.DrawText("HP: " .. trEnt:Health(), font, posX, posY + 40, color, TEXT_ALIGN_CENTER)
  draw.DrawText("AP: " .. entArmor, font, posX, posY + 60, color, TEXT_ALIGN_CENTER)
  draw.DrawText("Wep: " .. entWeaponName .. " [" .. entWeaponCName .. "]" .. " {" .. entActiveWepAmmo .. "}", font, posX, posY + 80, color, TEXT_ALIGN_CENTER)
  draw.DrawText("WP: " .. entWeaponProficiency, font, posX, posY + 100, color, TEXT_ALIGN_CENTER)
  draw.DrawText("Pos: (" .. tostring(round(entPos[1])) .. ", " .. tostring(round(entPos[2])) .. ", " .. tostring(round(entPos[3])) .. ")", font, posX, posY + 120, color, TEXT_ALIGN_CENTER)
  draw.DrawText("Ang: (" .. tostring(round(entAng[1])) .. ", " .. tostring(round(entAng[2])) .. ", " .. tostring(round(entAng[3])) .. ")", font, posX, posY + 140, color, TEXT_ALIGN_CENTER)
  local distTo = tostring(round(plyPos:Distance(entPos)))
  draw.DrawText("Dist To: " .. distTo, font, posX, posY + 160, color, TEXT_ALIGN_CENTER)
  return
end

hook.Add("HUDPaint", "HUDPaint_DrawGopalsHUD", DrawGopalsHUD)

ply:PrintMessage(HUD_PRINTCONSOLE, "\n[Gopal's HUD] Init complete.")