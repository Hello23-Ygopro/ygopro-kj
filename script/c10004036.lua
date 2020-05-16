--Cliffcutter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,aux.ExistingCardCondition(scard.cfilter))
	aux.AddEffectDescription(c,0,aux.ExistingCardCondition(scard.cfilter))
end
