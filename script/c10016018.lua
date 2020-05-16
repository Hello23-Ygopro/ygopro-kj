--Logos Curator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,nil,scard.con1)
end
--draw
scard.con1=aux.ExistingCardCondition(aux.KJDPileFilter(Card.IsSpell),LOCATION_DPILE)
scard.tg1=aux.DrawTarget(PLAYER_SELF)
scard.op1=aux.DrawOperation(PLAYER_SELF,1)
