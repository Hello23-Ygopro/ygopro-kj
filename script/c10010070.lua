--Lava-Tube Crawler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROT_WORM,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--get ability (power down)
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--get ability (power down)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
scard.op1=aux.TargetUpdatePowerOperation(1,-1000)
