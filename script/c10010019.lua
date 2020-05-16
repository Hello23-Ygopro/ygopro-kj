--Spinning Terror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DREAD_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
	--break
	aux.AddTriggerEffect(c,0,EVENT_DRAW,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,1,1,c),nil,scard.con1)
end
--break
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and r~=REASON_RULE
end
