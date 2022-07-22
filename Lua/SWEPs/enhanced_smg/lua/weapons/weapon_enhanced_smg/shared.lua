AddCSLuaFile()

-- Weapon information settings
SWEP.PrintName = "Enhanced SMG"
SWEP.Author = "CerebralDatabank"
SWEP.Contact = "CerebralDatabank@gmail.com"
SWEP.Purpose = "Shoot things! SMG modified to have a higher fire rate and much higher magazine size."
SWEP.Instructions = "Use +attack (MOUSE1) for primary fire"

-- Garry's Mod spawnlist settings
SWEP.Category = "CerebralDatabank's Weapons"
SWEP.Spawnable = true
SWEP.AdminOnly = true

-- Weapon settings
SWEP.Base = "weapon_base"
SWEP.Slot = 2
SWEP.SlotPos = 3
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.Weight = 5
SWEP.HoldType = "shotgun"
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

-- Appearance settings
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.UseHands = true

-- Sound settings
SWEP.ReloadSound	= "Weapon_SMG1.Reload"

-- Impact effect
SWEP.ImpactEffect = "Impact"

-- Primary fire settings
SWEP.Primary.Damage = 10
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.ClipSize = 70
SWEP.Primary.DefaultClip = 70
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.NumShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Spread = 0.2
SWEP.Primary.Recoil = 0.25
SWEP.Primary.Delay = 0.05
SWEP.Primary.Force = 1
SWEP.Primary.Tracer = TRACER_LINE
SWEP.Primary.TracerName = "Tracer"
SWEP.Primary.Sound = "Weapon_SMG1.Single"

-- Secondary fire settings
SWEP.Secondary.Damage = 0
SWEP.Secondary.Ammo = "SMG1_Grenade" -- TODO
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.TakeAmmo = 0
SWEP.Secondary.NumShots = 0
SWEP.Secondary.Automatic = true
SWEP.Secondary.Spread = 0
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Delay = 0
SWEP.Secondary.Force = 0
SWEP.Secondary.Tracer = TRACER_NONE;
SWEP.Secondary.TracerName = ""
SWEP.Secondary.Sound = ""


function SWEP:Initialize()
  self:SetWeaponHoldType("smg");
end

function SWEP:PrimaryAttack()
  if (!self:CanPrimaryAttack()) then return end
  local bullet = {}
  bullet.Num = self.Primary.NumShots;
  bullet.Src = self.Owner:GetShootPos()
  bullet.Dir = self.Owner:GetAimVector()
  bullet.Spread = Vector(self.Primary.Spread * 0.1, self.Primary.Spread * 0.1);
  bullet.Tracer = self.Primary.Tracer;
  bullet.TracerName = self.Primary.TracerName;
  bullet.Force = self.Primary.Force;
  bullet.Damage = self.Primary.Damage;
  bullet.AmmoType = self.Primary.Ammo;
  self.Owner:FireBullets(bullet)
  self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
  self.Owner:SetAnimation(PLAYER_ATTACK1)
  self.Owner:MuzzleFlash()
  self.Weapon:EmitSound(self.Primary.Sound)
  self.Owner:ViewPunch(Angle(-self.Primary.Recoil, 0, 0))
  self:TakePrimaryAmmo(self.Primary.TakeAmmo)
  if (self.Primary.Automatic) then
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
  end
end

function SWEP:SecondaryAttack()
  return
end

function SWEP:DoImpactEffect(tr, damagetype)
  if (tr.HitSky) then return end
  local effectdata = EffectData()
  effectdata:SetOrigin(tr.HitPos + tr.HitNormal)
  effectdata:SetNormal(tr.HitNormal)
  util.Effect(self.ImpactEffect, effectdata);
end

function SWEP:Reload()
  self:DefaultReload(ACT_VM_RELOAD);
  return true
end

function SWEP:Deploy()
  self:SendWeaponAnim(ACT_VM_DRAW);
  return true
end
 
function SWEP:Holster()
  return true
end

function SWEP:OnRemove()
end

function SWEP:OnRestore()
end
 
function SWEP:Think()
end