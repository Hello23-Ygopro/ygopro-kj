--Crimson Wyvern
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ATTACK_RAPTOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.BanishOperation(nil,scard.banfilter,0,LOCATION_BZONE))
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER)
end
