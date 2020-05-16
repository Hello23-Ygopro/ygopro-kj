--Warped Seeray
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_UNDERTOW_ENGINE)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--blocker
	aux.EnableBlocker(c)
	--confirm deck
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1)
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
