--Skybound Keeper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--power up
	aux.EnableUpdatePower(c,1000,aux.ExistingCardCondition(scard.cfilter))
	aux.AddEffectDescription(c,0,aux.ExistingCardCondition(scard.cfilter))
	--ignore skirmisher
	aux.EnableEffectCustom(c,EFFECT_IGNORE_SKIRMISHER,aux.ExistingCardCondition(scard.cfilter))
	aux.AddEffectDescription(c,1,aux.ExistingCardCondition(scard.cfilter))
end
--power up, ignore skirmisher
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
