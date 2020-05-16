--Skulking Cypress
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ZOMBIE,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--to mana zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.tomana(tp)
	scard.tomana(1-tp)
end
function scard.tomana(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOMZONE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToMZone,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
