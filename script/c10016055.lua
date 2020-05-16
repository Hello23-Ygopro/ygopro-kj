--Chief Headstrong Wanderer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--change level
	aux.EnableChangeClashManaCost(c,1,10)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--to mana zone
scard.tg1=aux.DecktopSendtoMZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
