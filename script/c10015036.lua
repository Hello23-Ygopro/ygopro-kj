--Cyber Savant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--confirm deck
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_SELF,nil,nil,nil,scard.op1)
end
--confirm deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.ConfirmCards(tp,g)
	if Duel.SelectYesNo(tp,YESNOMSG_TODECKBOT) then
		Duel.MoveSequence(g:GetFirst(),SEQ_DECK_BOTTOM)
	end
end
