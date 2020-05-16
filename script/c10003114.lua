--Hyperspeed Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (fast attack)
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK,scard.con1,LOCATION_BZONE,0,scard.tg1)
end
--get ability (fast attack)
function scard.cfilter(c)
	return c:IsFaceup() and c:KJIsRace(RACE_ARMORED_DRAGON)
end
function scard.con1(e)
	return Duel.IsExistingMatchingCard(scard.cfilter,e:GetHandlerPlayer(),LOCATION_BZONE,0,1,e:GetHandler())
end
scard.tg1=aux.TargetBoolFunction(Card.KJIsRace,RACE_ARMORED_DRAGON)
