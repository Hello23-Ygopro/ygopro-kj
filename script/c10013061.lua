--Attic Reaper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DREAD_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_DARKNESS))
	--unleash (get ability - power down)
	aux.EnableUnleash(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--unleash (get ability - power down)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
scard.op1=aux.TargetUpdatePowerOperation(1,-2000)
