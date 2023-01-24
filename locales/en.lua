local Translations = {
    error = {
        no_item = 'You are missing %{item}!',
       
        no_trimming_scissors = "You'll need trimming scissors for that!",
        no_coca_leaf = "You need sugar!",
        no_bakingsoda_amount = "You will need %{value} corn!",
        no_bakingsoda = "You will need corn!",
        no_cokain_amount = "You will need %{value} mash!",
        no_cokain = "You will need mash!",
        not_all_items = "You don't have the items you need!",
        already_processing = "You already process something!",
        not_enough_small_bricks = "You need %{value} small packets of cocaine!",
      
        too_far = "Processing was canceled because you left the area!",
      
    },
    success = {
       
        coke = "Sugar successfully processed!",
        coke_small_brick = "Mash made successfully!",
        coke_brick = "Moonshine ready for distribution!",
        
    },
    info = {

    },
    progressbar = {
        processing = "Process...",
        packing = "Packing...",
        collecting = "Collect......",
        
    },
    items = {
               coca_leaf = "Sugar",
        trimming_scissors = "Trimming scissors",
    },
    menu = {
        chemMenuHeader = "Chemistry menu",
        chemicals = "x1 Chemicals",
        close = "Close",
        closetxt = "Close menu",
    },
    target = {
        process_thionyl_chloride = "Process thionyl chloride",
        talk_to_walter = "Talk to Walter",
        talk_to_draco = "Talk to Draco",
        chemmenu = "Chemical compounds",
        methprocess = "Cook something wonderful and blue",
        methtempup = "Raise temperature",
        methtempdown = "Lower temperature",
        bagging = "Packing",
        keypad = "Exit lab",
        cokeleafproc = "Process sugar",
        cokepowdercut = "Refine Mash",
        pickCocaLeaves = "Collect Sugar Cane",
       
    },
  
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
