Rule={}
--register rules
--Not fully implemented: Tap a card to have it attack
function Rule.RegisterRules(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_ALL)
	e1:SetCountLimit(1)
	e1:SetOperation(Rule.ApplyRules)
	c:RegisterEffect(e1)
end
function Rule.ApplyRules(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(PLAYER_ONE,10000000)>0 then return end
	Duel.RegisterFlagEffect(PLAYER_ONE,10000000,0,0,0)
	--remove rules
	Rule.remove_rules(PLAYER_ONE)
	Rule.remove_rules(PLAYER_TWO)
	--shuffle deck
	Rule.shuffle_deck(PLAYER_ONE)
	Rule.shuffle_deck(PLAYER_TWO)
	--set lp
	Duel.SetLP(PLAYER_ONE,1)
	Duel.SetLP(PLAYER_TWO,1)
	--set shields
	Duel.SendDecktoptoSZone(PLAYER_ONE,5)
	Duel.SendDecktoptoSZone(PLAYER_TWO,5)
	--draw starting hand
	Duel.Draw(PLAYER_ONE,5,REASON_RULE)
	Duel.Draw(PLAYER_TWO,5,REASON_RULE)
	--untap
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetDescription(DESC_BEGINNING_PHASE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_UNTAP_STEP)
	e1:SetCondition(Rule.UntapCondition)
	e1:SetOperation(Rule.UntapOperation)
	Duel.RegisterEffect(e1,0)
	--charge
	local e2=Effect.GlobalEffect()
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetDescription(DESC_MANA_PHASE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetOperation(Rule.ChargeOperation)
	Duel.RegisterEffect(e2,0)
	--cannot attack (summoning sickness)
	local e3=Effect.GlobalEffect()
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetTargetRange(LOCATION_BZONE,LOCATION_BZONE)
	e3:SetTarget(Rule.CannotAttackTarget)
	Duel.RegisterEffect(e3,0)
	--add description (summoning sickness)
	local e3b=Effect.GlobalEffect()
	e3b:SetDescription(DESC_SUMMONSICKNESS)
	e3b:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CLIENT_HINT)
	e3b:SetType(EFFECT_TYPE_SINGLE)
	local e3c=Effect.GlobalEffect()
	e3c:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e3c:SetTargetRange(LOCATION_BZONE,LOCATION_BZONE)
	e3c:SetTarget(Rule.CannotAttackTarget)
	e3c:SetLabelObject(e3b)
	Duel.RegisterEffect(e3c,0)
	--cannot attack (cannot tap)
	local e4=e3:Clone()
	e4:SetTarget(aux.NOT(aux.TargetBoolFunction(Card.IsAbleToTap)))
	Duel.RegisterEffect(e4,0)
	--add description (cannot tap)
	local e4b=Effect.GlobalEffect()
	e4b:SetDescription(DESC_CANNOTATTACK)
	e4b:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CLIENT_HINT)
	e4b:SetType(EFFECT_TYPE_SINGLE)
	local e4c=Effect.GlobalEffect()
	e4c:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e4c:SetTargetRange(LOCATION_BZONE,LOCATION_BZONE)
	e4c:SetTarget(aux.NOT(aux.TargetBoolFunction(Card.IsAbleToTap)))
	e4c:SetLabelObject(e4b)
	Duel.RegisterEffect(e4c,0)
	--tap to attack workaround
	local e5=Effect.GlobalEffect()
	e5:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_ATTACK_END)
	e5:SetOperation(Rule.AttackTapOperation)
	Duel.RegisterEffect(e5,0)
	--enable attack player
	local e6=Effect.GlobalEffect()
	e6:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_ATTACK_PLAYER)
	e6:SetTargetRange(LOCATION_BZONE,LOCATION_BZONE)
	e6:SetTarget(aux.TargetBoolFunction(Card.IsCanAttackPlayer))
	Duel.RegisterEffect(e6,0)
	--destroy 0 power
	local e7=Effect.GlobalEffect()
	e7:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_ADJUST)
	e7:SetOperation(Rule.DestroyOperation1)
	Duel.RegisterEffect(e7,0)
	--discard resolved spell
	local e8=Effect.GlobalEffect()
	e8:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_CHAINING)
	e8:SetOperation(aux.chainreg)
	Duel.RegisterEffect(e8,0)
	local e9=e8:Clone()
	e9:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_DELAY)
	e9:SetCode(EVENT_CHAIN_SOLVED)
	e9:SetOperation(Rule.ResolveSpellOperation)
	Duel.RegisterEffect(e9,0)
	--win game
	local e10=Effect.GlobalEffect()
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_ADJUST)
	e10:SetOperation(Rule.WinOperation)
	Duel.RegisterEffect(e10,0)
	--override yugioh rules
	--attack first turn
	Rule.attack_first_turn()
	--cannot summon
	Rule.cannot_summon()
	--cannot mset
	Rule.cannot_mset()
	--cannot sset
	Rule.cannot_sset()
	--monster sset
	Rule.monster_sset()
	--cannot trigger
	Rule.cannot_trigger()
	--infinite hand
	Rule.infinite_hand()
	--infinite attacks
	Rule.infinite_attacks()
	--cannot conduct main phase 2
	Rule.cannot_main_phase2()
	--cannot change position
	Rule.cannot_change_position()
	--no battle damage
	Rule.avoid_battle_damage()
	--set def equal to atk
	Rule.def_equal_atk()
	--destroy equal/less def
	Rule.destroy_equal_less_def()
	--to grave
	Rule.to_grave()
	--set chain limit
	Rule.set_chain_limit()
	--cannot replay
	Rule.cannot_replay()
end
--remove rules
function Rule.remove_rules(tp)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_ALL,0,nil,10000000)
	if g:GetCount()==0 then return end
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_UNEXIST,REASON_RULE)
end
--shuffle deck
function Rule.shuffle_deck(tp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_RULE)
	Duel.ShuffleDeck(tp)
end
--untap
function Rule.UntapFilter(c)
	return c:IsFaceup() and c:IsAbleToUntapStartStep()
end
function Rule.UntapCondition(e)
	local turnp=Duel.GetTurnPlayer()
	return Duel.IsExistingMatchingCard(Rule.UntapFilter,turnp,LOCATION_BZONE,0,1,nil)
		or Duel.IsExistingMatchingCard(aux.ManaZoneFilter(Card.IsAbleToUntapStartStep),turnp,LOCATION_MZONE,0,1,nil)
end
function Rule.UntapOperation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	local g1=Duel.GetMatchingGroup(Rule.UntapFilter,turnp,LOCATION_BZONE,0,nil)
	local g2=Duel.GetMatchingGroup(aux.ManaZoneFilter(Card.IsAbleToUntapStartStep),turnp,LOCATION_MZONE,0,nil)
	g1:Merge(g2)
	Duel.Untap(g1,REASON_RULE)
end
--charge
function Rule.ChargeOperation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	local g=Duel.GetMatchingGroup(Card.IsAbleToMZone,turnp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,turnp,HINTMSG_TOMZONE)
	local sg=g:Select(turnp,0,1,nil)
	Duel.SendtoMZone(sg,POS_FACEUP_UNTAPPED,REASON_RULE)
end
--cannot attack (summoning sickness)
function Rule.CannotAttackTarget(e,c)
	return c:IsStatus(STATUS_TO_BZONE_TURN) and not c:IsCanAttackTurn()
end
--tap to attack workaround
function Rule.AttackTapOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() then
		Duel.Tap(tc,REASON_RULE)
	end
end
--destroy 0 power
function Rule.DestroyFilter(c)
	return c:IsFaceup() and c:GetPower()<=0 and not c:IsStatus(STATUS_BANISH_CONFIRMED)
end
function Rule.DestroyOperation1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Rule.DestroyFilter,0,LOCATION_BZONE,LOCATION_BZONE,nil)
	if Duel.KJBanish(g,REASON_RULE)>0 then
		Duel.Readjust()
	end
end
--discard resolved spell
function Rule.ResolveSpellOperation(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if not rc:IsSpell() or not rc:IsLocation(LOCATION_HAND) or e:GetHandler():GetFlagEffect(1)==0 then return end
	Duel.KJSendtoDPile(rc,REASON_RULE+REASON_DISCARD)
end
--win game
function Rule.WinOperation(e,tp,eg,ep,ev,re,r,rp)
	local win={}
	win[0]=Duel.GetFieldGroupCount(PLAYER_ONE,LOCATION_DECK,0)==0
	win[1]=Duel.GetFieldGroupCount(PLAYER_TWO,LOCATION_DECK,0)==0
	if win[0] and win[1] then
		Duel.Win(PLAYER_NONE,WIN_REASON_DECKOUT)
	elseif win[0] then
		Duel.Win(PLAYER_TWO,WIN_REASON_DECKOUT)
	elseif win[1] then
		Duel.Win(PLAYER_ONE,WIN_REASON_DECKOUT)
	end
end
--override yugioh rules
--attack first turn
function Rule.attack_first_turn()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_BP_FIRST_TURN)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot summon
function Rule.cannot_summon()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot mset
function Rule.cannot_mset()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_MSET)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot sset
function Rule.cannot_sset()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SSET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsLocation,LOCATION_HAND))
	Duel.RegisterEffect(e1,0)
end
--monster sset
function Rule.monster_sset()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_IGNORE_RANGE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetTargetRange(LOCATION_ALL,LOCATION_ALL)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCreature))
	e1:SetValue(TYPE_SPELL)
	Duel.RegisterEffect(e1,0)
end
--cannot trigger
function Rule.cannot_trigger()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsFacedown))
	Duel.RegisterEffect(e1,0)
end
--infinite hand
function Rule.infinite_hand()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_HAND_LIMIT)
	e1:SetTargetRange(1,1)
	e1:SetValue(MAX_NUMBER)
	Duel.RegisterEffect(e1,0)
end
--infinite attacks
function Rule.infinite_attacks()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetTargetRange(LOCATION_BZONE,LOCATION_BZONE)
	e1:SetValue(MAX_NUMBER)
	Duel.RegisterEffect(e1,0)
end
--cannot conduct main phase 2
function Rule.cannot_main_phase2()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_M2)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot change position
function Rule.cannot_change_position()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetTargetRange(LOCATION_BZONE,LOCATION_BZONE)
	Duel.RegisterEffect(e1,0)
end
--no battle damage
function Rule.avoid_battle_damage()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetTargetRange(LOCATION_BZONE,LOCATION_BZONE)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,0)
end
--set def equal to atk
function Rule.def_equal_atk()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_BASE_DEFENSE)
	e1:SetTargetRange(LOCATION_BZONE,LOCATION_BZONE)
	e1:SetValue(function(e,c)
		return c:GetPower()
	end)
	Duel.RegisterEffect(e1,0)
end
--destroy equal/less def
function Rule.destroy_equal_less_def()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetDescription(DESC_LOSE_BATTLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_END)
	e1:SetOperation(Rule.DestroyOperation2)
	Duel.RegisterEffect(e1,0)
end
function Rule.DestroyOperation2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a or not a:IsLocation(LOCATION_BZONE) or not d or not d:IsLocation(LOCATION_BZONE) or not d:IsDefensePos() then return end
	local ab1=a:IsHasEffect(EFFECT_UNBANISHABLE) or a:IsHasEffect(EFFECT_UNBANISHABLE_BATTLE)
	local ab2=d:IsHasEffect(EFFECT_UNBANISHABLE) or d:IsHasEffect(EFFECT_UNBANISHABLE_BATTLE)
	local g=Group.CreateGroup()
	local wc=nil
	local lc=nil
	if a:GetAttack()<d:GetDefense() then
		if not ab1 and a:IsRelateToBattle() then g:AddCard(a) wc=d lc=a end
	elseif a:GetAttack()==d:GetDefense() then
		if not ab1 and a:IsRelateToBattle() then g:AddCard(a) end
		if not ab2 and d:IsRelateToBattle() then g:AddCard(d) end
	end
	if wc then
		--raise event for "When this creature wins a battle"
		Duel.RaiseSingleEvent(wc,EVENT_CUSTOM+EVENT_WIN_BATTLE,e,0,0,0,0)
		--raise event for "Whenever one of your creatures wins a battle"
		Duel.RaiseEvent(wc,EVENT_CUSTOM+EVENT_WIN_BATTLE,e,0,0,0,0)
	end
	if lc then
		--(reserved) raise event for "When this creature loses a battle"
		--Duel.RaiseSingleEvent(lc,EVENT_CUSTOM+EVENT_LOSE_BATTLE,e,0,0,0,0)
		--raise event for "Whenever one of your creatures loses a battle"
		Duel.RaiseEvent(lc,EVENT_CUSTOM+EVENT_LOSE_BATTLE,e,0,0,0,0)
	end
	Duel.KJBanish(g,REASON_BATTLE+REASON_RULE)
	--raise events because EVENT_BANISHED will not trigger if REASON_BATTLE is included
	local og=Duel.GetOperatedGroup()
	for oc in aux.Next(og) do
		--raise event for "When this creature is banished"
		Duel.RaiseSingleEvent(oc,EVENT_BANISHED,e,REASON_BATTLE,0,0,0)
	end
	--raise event for "Whenever another creature is banished"
	Duel.RaiseEvent(og,EVENT_BANISHED,e,REASON_BATTLE,0,0,0)
end
--to grave
function Rule.to_grave()
	--prevent destroyed cards from being sent to the mana zone
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TO_MZONE_REDIRECT)
	e1:SetTargetRange(LOCATION_ALL,LOCATION_ALL)
	e1:SetTarget(Rule.ToGraveTarget)
	e1:SetValue(LOCATION_DPILE)
	Duel.RegisterEffect(e1,0)
	--prevent attached cards from being sent to the mana zone
	local e2=Effect.GlobalEffect()
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(Rule.ToGraveCondition)
	e2:SetOperation(Rule.ToGraveOperation)
	Duel.RegisterEffect(e2,0)
end
function Rule.ToGraveTarget(e,c)
	return c:IsReason(REASON_BANISH+REASON_BATTLE) and not c:IsHasEffect(EFFECT_TO_DPILE_REDIRECT)
end
function Rule.ToGraveCondition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsHasUnderlyingCard,1,nil)
end
function Rule.ToGraveOperation(e,tp,eg,ep,ev,re,r,rp)
	for ec in aux.Next(eg) do
		local g=ec:GetUnderlyingGroup():Filter(Card.KJIsAbleToDPile,nil)
		Duel.KJBanish(g,REASON_RULE)
	end
end
--set chain limit
function Rule.set_chain_limit()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetOperation(Rule.SetChainLimitOperation)
	Duel.RegisterEffect(e1,0)
end
function Rule.SetChainLimitOperation(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasProperty(EFFECT_FLAG_CHAIN_LIMIT) then
		Duel.SetChainLimit(aux.FALSE)
	end
end
--cannot replay
function Rule.cannot_replay()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg:IsExists(Card.IsPreviousLocation,1,nil,LOCATION_BZONE+LOCATION_SZONE) and Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local a=Duel.GetAttacker()
		local d=Duel.GetAttackTarget()
		--[[if not d or not d:IsLocation(LOCATION_BZONE) then
			Duel.Tap(a,REASON_RULE)
			return
		end]]
		Duel.ChangeAttackTarget(d)
	end)
	Duel.RegisterEffect(e1,0)
end
--[[
	References
	1. A creature that has a power 0 or less is immediately destroyed
	* Call of Darkness
	https://github.com/Fluorohydride/ygopro-scripts/blob/9c40273/c78637313.lua#L12
	* Rivalry of Warlords
	https://github.com/Fluorohydride/ygopro-scripts/blob/55de4af/c90846359.lua#L14
	2. You win the game when your opponent has no cards left in their deck
	* Ghostrick Angel of Mischief
	https://github.com/Fluorohydride/ygopro-scripts/blob/master/c53334641.lua#L10
	3. Rule: A card sent to the graveyard is banished instead
	* Macro Cosmos
	https://github.com/Fluorohydride/ygopro-scripts/blob/2fcfdf8/c30241314.lua#L16
]]
