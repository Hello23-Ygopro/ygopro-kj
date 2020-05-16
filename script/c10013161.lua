--Caius of Cloud Legion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability (shield blast)
	aux.EnableEffectCustom(c,EFFECT_SHIELD_BLAST,nil,LOCATION_ALL,0,scard.tg1)
end
--get ability (shield blast)
function scard.tg1(e,c)
	return c:IsCreature() and c:IsCivilization(CIVILIZATION_LIGHT) and (c:IsShield() or c:IsBrokenShield())
end
