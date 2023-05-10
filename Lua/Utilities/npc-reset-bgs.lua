if (!SERVER) then
  PrintMessage(HUD_PRINTCONSOLE, "[NPC Reset Bodygroups] Must be run serverside; exiting.")
  return
end

for k, ent in pairs(ents.GetAll()) do
  if ent:IsNPC() then
    for k2, bg in pairs(ent:GetBodyGroups()) do
      ent:SetBodygroup(bg.id, 0)
    end
  end
end

PrintMessage(HUD_PRINTCONSOLE, "[NPC Reset Bodygroups] Done.")