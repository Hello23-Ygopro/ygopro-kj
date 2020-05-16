--Obsidian Death
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TARBORG,RACE_COLOSSUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to mana zone
	aux.AddTriggerEffect(c,0,EVENT_BANISHED,true,aux.DecktopSendtoMZoneTarget(PLAYER_SELF),scard.op1,nil,aux.LeaveBZoneCondition())
end
--to mana zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	aux.DecktopSendtoMZoneOperation(PLAYER_SELF,eg:GetCount())(e,tp,eg,ep,ev,re,r,rp)
end
