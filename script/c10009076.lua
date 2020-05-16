--Haunted Harvest
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EVIL_TOY,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BLOCK,true,scard.tg1,scard.op1)
end
--to mana zone
scard.tg1=aux.DecktopSendtoMZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
