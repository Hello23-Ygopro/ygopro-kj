--Cloudwalker Drone
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,1000,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:KJIsRace(RACE_ENFORCER)
end
function scard.con1(e)
	return Duel.IsExistingMatchingCard(scard.cfilter,e:GetHandlerPlayer(),LOCATION_BZONE,0,1,e:GetHandler())
end
