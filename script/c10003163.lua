--The Great Arena
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIVING_CITY)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.con1)
end
--draw
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:IsPowerAbove(5000) and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,e:GetHandler(),tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,eg:GetCount(),REASON_EFFECT)
end
