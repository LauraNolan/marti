var kill_chain_load = true;
var available_kill_chains = [];
$(document).ready(function() {
    $("#kill_chain_list").tagit({
        allowSpaces: true,
        allowDuplicates: false,
        removeCOnfirmation: true,
        showAutocompleteOnFocus: true,
        beforeTagAdded: function(event, ui) {
            if (available_kill_chains.indexOf(ui.tagLabel) == -1) {
                return false;
            }
            if (ui.tagLabel == "not found") {
                return false;
            }
        },
        afterTagAdded: function(event, ui) {
            var my_kill_chains = $("#kill_chain_list").tagit("assignedTags");
            update_kill_chains(my_kill_chains);
        },
        afterTagRemoved: function(event, ui) {
            var my_kill_chains = $("#kill_chain_list").tagit("assignedTags");
            update_kill_chains(my_kill_chains);
        },
        onTagClicked: function(event, ui) {
            var url = kill_chain_search + "?search_type=kill_chains&force_full=1&search=Search&q=" + ui.tagLabel;
            window.location.href = url;
        },
        availableTags: (function() {
            var tmp = [];
            $.ajax({
                async: false,
                type: "POST",
                url: kill_chain_list,
                data: {},
                datatype: 'json',
                success: function(data) {
                    available_kill_chains = tmp = data;
                }
            });
            return tmp;
        })(),
        autocomplete: {
            delay: 0,
            minLength: 0,
        },
    });
    function update_kill_chains(my_kill_chains) {
        if (!kill_chain_load) {
            var oid = subscription_id;
            var itype = subscription_type;
            var data = {
                        'oid': oid,
                        'kill_chains': my_kill_chains.toString(),
                        'itype': itype
            };
            $.ajax({
                type: "POST",
                url: kill_chain_modify,
                data: data,
                datatype: 'json',
            });
        }
    }
    $(document).trigger('enable_kill_chains');
}); //document.ready
