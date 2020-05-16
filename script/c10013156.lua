--Flame Serpent
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TSUNAMI_DRAGON,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,3000)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability (cannot be blocked)
	aux.AddStaticEffectCannotBeBlocked(c,LOCATION_BZONE,0,scard.tg1)
	if not scard.global_check then
		scard.global_check=true
		scard[0]=0
		scard[1]=0
		--check attacking creature
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge1:SetOperation(scard.checkop1)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ATTACK_DISABLED)
		ge2:SetOperation(scard.checkop2)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge3:SetOperation(scard.clearop)
		Duel.RegisterEffect(ge3,0)
	end
end
--check attacking creature
function scard.checkop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:GetFlagEffect(sid)==0 then
		scard[tc:GetControler()]=scard[tc:GetControler()]+1
		tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
function scard.checkop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	scard[tc:GetControler()]=scard[tc:GetControler()]-1
end
function scard.clearop(e,tp,eg,ep,ev,re,r,rp)
	scard[0]=0
	scard[1]=0
end
--get ability (cannot be blocked)
function scard.tg1(e,c)
	return scard[c:GetControler()]==0 and c:GetFlagEffect(sid)==0
end
--[[
	References
		1. Ogre of the Scarlet Sorrow
		https://github.com/Fluorohydride/ygopro-scripts/blob/2c4f0ca/c82670878.lua#L23
		2. Confusion Chaff
		https://github.com/Fluorohydride/ygopro-scripts/blob/2c4f0ca/c67630339.lua#L10
]]
