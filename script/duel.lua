--Overwritten Duel functions
--send a card to a player's hand
--Note: Overwritten to send a card's evolution source to the hand
local duel_send_to_hand=Duel.SendtoHand
function Duel.SendtoHand(targets,player,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc in aux.Next(targets) do
		local g=tc:GetUnderlyingGroup()
		targets:Merge(g)
	end
	return duel_send_to_hand(targets,player,reason)
end
--send a card to a player's deck
--Note: Overwritten to send a card's evolution source to the deck
local duel_send_to_deck=Duel.SendtoDeck
function Duel.SendtoDeck(targets,player,seq,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc in aux.Next(targets) do
		local g=tc:GetUnderlyingGroup()
		targets:Merge(g)
	end
	local res=duel_send_to_deck(targets,player,seq,reason)
	if seq==SEQ_DECK_TOP or seq==SEQ_DECK_BOTTOM then
		local dct1=Duel.GetOperatedGroup():FilterCount(Card.IsControler,nil,0)
		local dct2=Duel.GetOperatedGroup():FilterCount(Card.IsControler,nil,1)
		if dct1>1 then
			Duel.SortDecktop(player,0,dct1)
			if seq==SEQ_DECK_BOTTOM then
				for i=1,dct1 do
					local mg=Duel.GetDecktopGroup(PLAYER_ONE,1)
					Duel.MoveSequence(mg:GetFirst(),SEQ_DECK_BOTTOM)
				end
			end
		end
		if dct2>1 then
			Duel.SortDecktop(player,1,dct2)
			if seq==SEQ_DECK_BOTTOM then
				for i=1,dct2 do
					local mg=Duel.GetDecktopGroup(PLAYER_TWO,1)
					Duel.MoveSequence(mg:GetFirst(),SEQ_DECK_BOTTOM)
				end
			end
		end
	end
	return res
end
--send a card to the battle zone
--Note: Overwritten to notify a player if all zones are occupied
local duel_special_summon_step=Duel.SpecialSummonStep
function Duel.SpecialSummonStep(c,sumtype,sumplayer,target_player,nocheck,nolimit,pos)
	if Duel.GetLocationCount(target_player,LOCATION_BZONE)==0 then
		Duel.Hint(HINT_MESSAGE,sumplayer,ERROR_NOBZONES)
		return false
	end
	return duel_special_summon_step(c,sumtype,sumplayer,target_player,nocheck,nolimit,pos)
end
Duel.SendtoBZoneStep=Duel.SpecialSummonStep
local duel_special_summon=Duel.SpecialSummon
function Duel.SpecialSummon(targets,sumtype,sumplayer,target_player,nocheck,nolimit,pos,zone)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	zone=zone or ZONE_MZONE
	local res=0
	for tc in aux.Next(targets) do
		if Duel.GetLocationCount(target_player,LOCATION_BZONE)>0 then
			--check for "This creature enters the battle zone tapped."
			if tc:IsHasEffect(EFFECT_ENTER_BZONE_TAPPED) then pos=POS_FACEUP_TAPPED end
			--check for an evolution creature
			if tc:IsEvolution() then
				Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_EVOLUTION_TO_BZONE,Effect.GlobalEffect(),0,0,0,0)
			end
			if Duel.SpecialSummonStep(tc,sumtype,sumplayer,target_player,nocheck,nolimit,pos,zone) then
				res=res+1
			end
		else
			Duel.Hint(HINT_MESSAGE,sumplayer,ERROR_NOBZONES)
		end
	end
	Duel.SpecialSummonComplete()
	return res
end
Duel.SendtoBZone=Duel.SpecialSummon
Duel.SendtoBZoneComplete=Duel.SpecialSummonComplete
--change the position of a card
--Note: Added parameter reason (not fully implemented)
local duel_change_position=Duel.ChangePosition
function Duel.ChangePosition(targets,pos,reason)
	reason=reason or REASON_EFFECT
	return duel_change_position(targets,pos,reason)
end
--draw a card
--Note: Overwritten to check if a player's deck size is less than the number of cards they will draw
local duel_draw=Duel.Draw
function Duel.Draw(player,count,reason)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and count>deck_count then count=deck_count end
	return duel_draw(player,count,reason)
end
--check if a player can draw a card
--Note: Overwritten to check if a player's deck size is less than the number of cards they will draw
local duel_is_player_can_draw=Duel.IsPlayerCanDraw
function Duel.IsPlayerCanDraw(player,count)
	count=count or 0
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and count>deck_count then count=deck_count end
	return duel_is_player_can_draw(player,count)
end
--discard a card
--Note: Overwritten to banish a discarded card
function Duel.DiscardHand(player,f,min,max,reason,ex,...)
	max=max or min
	reason=reason or REASON_EFFECT
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(player,f,player,LOCATION_HAND,0,min,max,ex,...)
	if g:GetCount()==0 then return 0 end
	return Duel.Remove(g,POS_FACEUP,reason+REASON_DISCARD)
end
--select a card
--Note: Shields are selected at random for abilities that select either player's shields
local duel_select_matching_card=Duel.SelectMatchingCard
function Duel.SelectMatchingCard(sel_player,f,player,s,o,min,max,ex,...)
	if sel_player==player and s==LOCATION_SZONE then
		--Note: Remove this if YGOPro can forbid players to look at their face-down cards
		local g=Duel.GetMatchingGroup(aux.ShieldZoneFilter(f),player,s,o,ex,...)
		return g:RandomSelect(sel_player,min,max)
	else
		if not Duel.IsExistingMatchingCard(f,player,s,o,1,ex,...) then
			Duel.Hint(HINT_MESSAGE,sel_player,ERROR_NOTARGETS)
		end
		return duel_select_matching_card(sel_player,f,player,s,o,min,max,ex,...)
	end
end
--target a card
--Note: Shields are selected at random for abilities that select either player's shields
local duel_select_target=Duel.SelectTarget
function Duel.SelectTarget(sel_player,f,player,s,o,min,max,ex,...)
	if sel_player==player and s==LOCATION_SZONE then
		--Note: Remove this if YGOPro can forbid players to look at their face-down cards
		local g=Duel.GetMatchingGroup(aux.ShieldZoneFilter(f),player,s,o,ex,...)
		local sg=g:RandomSelect(sel_player,min,max)
		Duel.SetTargetCard(sg)
		return sg
	else
		if not Duel.IsExistingTarget(f,player,s,o,1,ex,...) then
			Duel.Hint(HINT_MESSAGE,sel_player,ERROR_NOTARGETS)
		end
		return duel_select_target(sel_player,f,player,s,o,min,max,ex,...)
	end
end
--New Duel functions
--tap a card
function Duel.Tap(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		if tc:IsAbleToTap() then
			if tc:IsLocation(LOCATION_BZONE) then
				res=res+Duel.ChangePosition(tc,POS_FACEUP_TAPPED,reason)
			elseif tc:IsLocation(LOCATION_MZONEUNT) then
				res=res+Duel.Remove(tc,POS_FACEDOWN,reason)
				Duel.RaiseSingleEvent(tc,EVENT_CHANGE_POS,Effect.GlobalEffect(),reason,0,0,0)
				Duel.RaiseEvent(tc,EVENT_CHANGE_POS,Effect.GlobalEffect(),reason,0,0,0)
			end
		end
	end
	return res
end
--untap a card
function Duel.Untap(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		if tc:IsAbleToUntap() then
			if tc:IsLocation(LOCATION_BZONE) then
				res=res+Duel.ChangePosition(tc,POS_FACEUP_UNTAPPED,reason)
			elseif tc:IsLocation(LOCATION_MZONETAP) then
				res=res+Duel.SendtoGrave(tc,reason)
				Duel.RaiseSingleEvent(tc,EVENT_CHANGE_POS,Effect.GlobalEffect(),reason,0,0,0)
				Duel.RaiseEvent(tc,EVENT_CHANGE_POS,Effect.GlobalEffect(),reason,0,0,0)
			end
		end
	end
	return res
end
--tap a card in the mana zone to summon a creature or to cast a spell
function Duel.PayManaCost(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		res=res+Duel.Tap(targets,REASON_COST)
	end
	return res
end
--break a shield
function Duel.BreakShield(sel_player,target_player,min,max,rc,reason)
	--sel_player: the player who selects the shield to break
	--target_player: the player whose shield to break
	--min,max: the minimum and maximum number of shields to break
	--rc: the creature that breaks the shield
	--reason: the reason for breaking the shield (REASON_EFFECT by default)
	reason=reason or REASON_EFFECT
	Duel.Tap(rc,REASON_RULE) --fix creature not being tapped when attacking
	local g=Duel.GetMatchingGroup(aux.ShieldZoneFilter(),target_player,LOCATION_SZONE,0,nil)
	local ct=g:GetCount()
	if ct==0 then return 0 end
	if rc then
		if not rc:IsCanBreakShield() then return 0 end
		--check for "Breaker"
		local db=rc:IsHasEffect(EFFECT_DOUBLE_BREAKER)
		local tb=rc:IsHasEffect(EFFECT_TRIPLE_BREAKER)
		local wb=rc:IsHasEffect(EFFECT_WORLD_BREAKER)
		if rc:GetEffectCount(EFFECT_BREAKER)==1 then
			if db then min,max=2,2
			elseif tb then min,max=3,3
			elseif wb then min,max=ct,ct end
		elseif rc:GetEffectCount(EFFECT_BREAKER)>1 then
			local available_list={}
			if db then table.insert(available_list,1) end
			if tb then table.insert(available_list,2) end
			if wb then table.insert(available_list,3) end
			local option_list={}
			for _,ab in pairs(available_list) do
				table.insert(option_list,aux.break_select_list[ab])
			end
			Duel.Hint(HINT_SELECTMSG,sel_player,HINTMSG_APPLYABILITY)
			local opt=Duel.SelectOption(sel_player,table.unpack(option_list))+1
			if opt==1 then min,max=2,2
			elseif opt==2 then min,max=3,3
			elseif opt==3 then min,max=ct,ct end
		end
		--check for "breaks an additional shield"
		if rc:IsHasEffect(EFFECT_BREAK_EXTRA_SHIELD) then
			min=min+rc:GetEffectCount(EFFECT_BREAK_EXTRA_SHIELD)
			max=min
		end
	end
	Duel.Hint(HINT_SELECTMSG,sel_player,HINTMSG_BREAK)
	local sg=g:Select(sel_player,min,max,nil)
	Duel.HintSelection(sg)
	local res=0
	--register broken shields
	for sc in aux.Next(sg) do
		--add description
		sc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD-RESET_TOHAND-RESET_LEAVE,EFFECT_FLAG_CLIENT_HINT,1,0,DESC_BROKEN)
		--register Card.IsBrokenShield
		sc:RegisterFlagEffect(EFFECT_BROKEN_SHIELD,RESET_EVENT+RESETS_STANDARD-RESET_TOHAND-RESET_LEAVE,0,1)
		--register Card.GetBrokenShieldCount
		rc:RegisterFlagEffect(EFFECT_BREAK_SHIELD,RESET_PHASE+PHASE_END,0,1)
		--register Duel.GetBrokenShieldCount
		Duel.RegisterFlagEffect(rc:GetControler(),EFFECT_BREAK_SHIELD,RESET_PHASE+PHASE_END,0,1)
	end
	res=res+Duel.SendtoHand(sg,PLAYER_OWNER,reason+REASON_BREAK)
	local og=Duel.GetOperatedGroup()
	for oc in aux.Next(og) do
		--add message
		if not oc:IsHasEffect(EFFECT_SHIELD_BLAST) then Duel.Hint(HINT_MESSAGE,target_player,ERROR_NOSBLAST) end
		--raise event for "Shield Blast"
		Duel.RaiseSingleEvent(oc,EVENT_CUSTOM+EVENT_TRIGGER_SHIELD_BLAST,Effect.GlobalEffect(),0,0,0,0)
	end
	local hg=Duel.GetFieldGroup(0,LOCATION_HAND,LOCATION_HAND)
	for hc in aux.Next(hg) do
		--reset Card.IsBrokenShield
		if not og:IsContains(hc) then hc:ResetFlagEffect(EFFECT_BROKEN_SHIELD) end
	end
	return res
end
aux.break_select_list={
	[1]=DESC_DOUBLE_BREAKER,[2]=DESC_TRIPLE_BREAKER,[3]=DESC_WORLD_BREAKER,
}
--send a card to the mana zone
function Duel.SendtoMZone(targets,pos,reason)
	--pos: POS_FACEUP_UNTAPPED for untapped position or POS_FACEUP_TAPPED for tapped position
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--check for multicolored cards
	local g1=targets:Filter(Card.IsMulticolored,nil)
	targets:Sub(g1)
	local res=0
	for tc1 in aux.Next(targets) do
		if tc1:IsAbleToMZone() then
			local g2=tc1:GetUnderlyingGroup()
			if pos==POS_FACEUP_UNTAPPED then
				res=res+Duel.SendtoGrave(g2,reason)
				res=res+Duel.SendtoGrave(tc1,reason)
			elseif pos==POS_FACEUP_TAPPED then
				res=res+Duel.Remove(g2,POS_FACEDOWN,reason)
				res=res+Duel.Remove(tc1,POS_FACEDOWN,reason)
			end
		end
	end
	--multicolored cards enter the mana zone tapped
	for tc2 in aux.Next(g1) do
		if tc2:IsAbleToMZone() then
			local g2=tc2:GetUnderlyingGroup()
			res=res+Duel.Remove(g2,POS_FACEDOWN,REASON_RULE)
		end
	end
	res=res+Duel.Remove(g1,POS_FACEDOWN,REASON_RULE)
	return res
end
--send a card to the discard pile
function Duel.KJSendtoDPile(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc1 in aux.Next(targets) do
		if tc1:KJIsAbleToDPile() then
			local g=tc1:GetUnderlyingGroup()
			for tc2 in aux.Next(g) do
				res=res+Duel.Remove(tc2,POS_FACEUP,reason)
			end
			if tc1:IsLocation(LOCATION_MZONETAP) and tc1:IsFacedown() then
				--workaround to banish a banished card
				--Note: Remove this if YGOPro can flip a face-down banished card face-up
				if Duel.SendtoHand(tc1,PLAYER_OWNER,REASON_RULE+REASON_TEMPORARY)>0 then
					Duel.ConfirmCards(1-tc1:GetControler(),tc1)
				end
			end
			res=res+Duel.Remove(tc1,POS_FACEUP,reason)
		end
	end
	return res
end
--send a card to the shield zone
function Duel.SendtoSZone(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc1 in aux.Next(targets) do
		if tc1:IsAbleToSZone() then
			--send evolution source to shield zone first to prevent the game from removing it
			local g=tc1:GetUnderlyingGroup()
			for tc2 in aux.Next(g) do
				if tc2:IsAbleToSZone() then
					if Duel.GetLocationCount(tc2:GetOwner(),LOCATION_SZONE)>0 then
						if Duel.MoveToField(tc2,tc2:GetOwner(),tc2:GetOwner(),LOCATION_SZONE,POS_FACEDOWN,true) then
							res=res+1
						end
					else
						Duel.Hint(HINT_MESSAGE,tc2:GetOwner(),ERROR_NOSZONES)
					end
				end
			end
			if Duel.GetLocationCount(tc1:GetOwner(),LOCATION_SZONE)>0 then
				if Duel.MoveToField(tc1,tc1:GetOwner(),tc1:GetOwner(),LOCATION_SZONE,POS_FACEDOWN,true) then
					res=res+1
				end
			else
				Duel.Hint(HINT_MESSAGE,tc1:GetOwner(),ERROR_NOSZONES)
			end
		end
	end
	return res
end
--send a card from the top of a player's deck to the mana zone
function Duel.SendDecktoptoMZone(player,count,pos,reason)
	--player: the player whose cards to send to the mana zone
	--count: the number of cards to send to the mana zone
	local g=Duel.GetDecktopGroup(player,count)
	Duel.DisableShuffleCheck()
	return Duel.SendtoMZone(g,pos,reason)
end
--send a card from the top of a player's deck to the discard pile
function Duel.KJSendDecktoptoDPile(player,count,reason)
	--player: the player whose cards to send to the discard pile
	--count: the number of cards to send to the discard pile
	local g=Duel.GetDecktopGroup(player,count)
	Duel.DisableShuffleCheck()
	return Duel.KJSendtoDPile(g,reason)
end
--send a card from the top of a player's deck to the shield zone
function Duel.SendDecktoptoSZone(player,count)
	--player: the player whose cards to send to the shield zone
	--count: the number of cards to send to the shield zone
	local g=Duel.GetDecktopGroup(player,count)
	Duel.DisableShuffleCheck()
	return Duel.SendtoSZone(g)
end
--send up to a number of cards from the top of a player's deck to the mana zone
function Duel.SendDecktoptoMZoneUpTo(player,count,pos,reason)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and Duel.IsPlayerCanSendDecktoptoMZone(player,1) and Duel.SelectYesNo(player,YESNOMSG_TOMZONE) then
		if deck_count>count then deck_count=count end
		local t={}
		for i=1,deck_count do t[i]=i end
		Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ANNOUNCETOMZONE)
		local an=Duel.AnnounceNumber(player,table.unpack(t))
		return Duel.SendDecktoptoMZone(player,an,pos,reason)
	end
	return 0
end
--check if a player can send a card from the top of their deck to the discard pile
function Duel.KJIsPlayerCanSendDecktoptoDPile(player,count)
	local g=Duel.GetDecktopGroup(player,count)
	return g:FilterCount(Card.KJIsAbleToDPile,nil)>0
end
--check if a player can send a card from the top of their deck to the shield zone
function Duel.IsPlayerCanSendDecktoptoSZone(player,count)
	local g=Duel.GetDecktopGroup(player,count)
	return g:FilterCount(Card.IsAbleToSZone,nil)>0
end
--put a card on top of another card
function Duel.PutOnTop(c,targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	c:SetMaterial(targets)
	for tc in aux.Next(targets) do
		--retain underlying cards
		local g=tc:GetUnderlyingGroup()
		if g:GetCount()>0 then
			Duel.Overlay(c,g)
		end
		Duel.Overlay(c,tc)
	end
end
--draw up to a number of cards
function Duel.DrawUpTo(player,count,reason)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and Duel.IsPlayerCanDraw(player,1) and Duel.SelectYesNo(player,YESNOMSG_DRAW) then
		if deck_count>count then deck_count=count end
		local t={}
		for i=1,deck_count do t[i]=i end
		Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ANNOUNCEDRAW)
		local draw_count=Duel.AnnounceNumber(player,table.unpack(t))
		return Duel.Draw(player,draw_count,reason)
	end
	return 0
end
--discard a card at random
function Duel.RandomDiscardHand(player,count,reason,ex)
	reason=reason or REASON_EFFECT
	local g=Duel.GetFieldGroup(player,LOCATION_HAND,0)
	if type(ex)=="Card" then g:RemoveCard(ex)
	elseif type(ex)=="Group" then g:Sub(ex) end
	if g:GetCount()==0 then return 0 end
	local sg=g:RandomSelect(player,count)
	return Duel.Remove(sg,POS_FACEUP,reason+REASON_DISCARD)
end
--get the creature that is blocking
function Duel.GetBlocker()
	local f=function(c)
		return c:GetFlagEffect(EFFECT_BLOCKER)>0
	end
	return Duel.GetFirstMatchingCard(f,0,LOCATION_BZONE,LOCATION_BZONE,nil)
end
--get the number of shields a player has
function Duel.GetShieldCount(player)
	return Duel.GetMatchingGroupCount(aux.ShieldZoneFilter(),player,LOCATION_SZONE,0,nil)
end
--get the number of shields a player's cards broke this turn
function Duel.GetBrokenShieldCount(player)
	return Duel.GetFlagEffect(player,EFFECT_BREAK_SHIELD)
end
--cast a spell immediately for no cost
function Duel.CastFree(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		--Duel.DisableShuffleCheck(true)
		--Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
		Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_CAST_FREE,tc:GetReasonEffect(),0,0,0,0)
		--Duel.DisableShuffleCheck(false)
		res=res+1
	end
	return res
end
--each player reveals the top card of their deck
--a player wins the clash if their card's mana cost is the same or higher as their opponent's card
function Duel.Clash(player)
	--player: the player who initiates the clash
	local ct1=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	local ct2=Duel.GetFieldGroupCount(player,0,LOCATION_DECK)
	if ct1==0 or ct2==0 then return end
	Duel.ConfirmDecktop(player,1)
	local tc1=Duel.GetDecktopGroup(player,1):GetFirst()
	Duel.RaiseEvent(tc1,EVENT_CUSTOM+EVENT_CLASH,Effect.GlobalEffect(),0,0,player,0)
	Duel.RaiseSingleEvent(tc1,EVENT_CUSTOM+EVENT_CLASH,Effect.GlobalEffect(),0,0,player,0)
	Duel.ConfirmDecktop(1-player,1)
	local tc2=Duel.GetDecktopGroup(1-player,1):GetFirst()
	Duel.RaiseEvent(tc2,EVENT_CUSTOM+EVENT_CLASH,Effect.GlobalEffect(),0,0,1-player,0)
	Duel.RaiseSingleEvent(tc2,EVENT_CUSTOM+EVENT_CLASH,Effect.GlobalEffect(),0,0,1-player,0)
	local win_clash=tc1:GetManaCost()>=tc2:GetManaCost()
	local lose_clash=tc1:GetManaCost()<tc2:GetManaCost()
	if win_clash then
		Duel.Hint(HINT_MESSAGE,player,DESC_WINCLASH)
		Duel.Hint(HINT_MESSAGE,1-player,DESC_LOSECLASH)
	elseif lose_clash then
		Duel.Hint(HINT_MESSAGE,player,DESC_LOSECLASH)
		Duel.Hint(HINT_MESSAGE,1-player,DESC_WINCLASH)
	end
	Duel.MoveSequence(tc1,SEQ_DECK_BOTTOM)
	Duel.MoveSequence(tc2,SEQ_DECK_BOTTOM)
	if win_clash then
		return true
	elseif lose_clash then
		return false
	end
end
--check if a player can clash with their opponent
function Duel.IsPlayerCanClash(player)
	local ct1=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	local ct2=Duel.GetFieldGroupCount(player,0,LOCATION_DECK)
	return ct1>0 and ct2>0
end
--get the card a card unleashed with
function Duel.GetUnleashCard(c)
	local f=function(target,c)
		return target:GetFlagEffectLabel(EFFECT_UNLEASH)==c:GetCode()
	end
	return Duel.GetFirstMatchingCard(aux.KJDPileFilter(f),c:GetControler(),LOCATION_DPILE,0,nil,c)
end
--Renamed Duel functions
--banish a card
Duel.KJBanish=Duel.Destroy
--let 2 creatures do battle with each other
Duel.DoBattle=Duel.CalculateDamage
--check if a player can send a card from the top of their deck to the mana zone
Duel.IsPlayerCanSendDecktoptoMZone=Duel.IsPlayerCanDiscardDeck
