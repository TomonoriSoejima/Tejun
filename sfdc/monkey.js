// ==UserScript==
// @name         Give me Shard notes (Tomo.Soejima)
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Show shard notes in console from all Salesforce case's comments
// @author       @tomo.soejima
// @match        https://elastic.my.salesforce.com/*
// @grant        none
// ==/UserScript==
(function() {
    'use strict';

    let hasRunFindShardNotes = false;
    //  Function to simulate a click on the "Show More" button
    function clickShowMoreButton() {
        const showMoreButtons = document.querySelectorAll('div.cxshowmorefeeditemscontainer.showmorefeeditemscontainer a');
        for (const button of showMoreButtons) {
            const paginationToken = button.getAttribute('onclick').match(/'([^']+)'/)[1];
            button.click();
            console.log(`Clicked "Show More" button with paginationToken: ${paginationToken}`);
        }
    }

    // Function to simulate a click on the "Expand All Field Items" button
    function clickExpandAllButton() {
        const expandAllButton = document.querySelector('div.entityFeedHeaderActions a[onclick^="chatter.getFeed().expandAllCompactFeedItems()"]');
        if (expandAllButton) {
            expandAllButton.click();
            console.log('Clicked "Expand All Field Items" button.');
        }
    }

    // Function to execute clickShowMoreButton and clickExpandAllButton sequentially. It checks if the page has the cxFeedItems, to confirm it is a case with comments
    function executeActions() {
        const cxFeedItems = document.querySelectorAll('.cxfeeditem.feeditem');
        if (cxFeedItems.length > 0) {
            const showMoreButtons = document.querySelectorAll('div.cxshowmorefeeditemscontainer.showmorefeeditemscontainer a');
            if (showMoreButtons.length > 0) {
                clickShowMoreButton();
            } else {
                clearInterval(intervalId);
                clickExpandAllButton();
            }
        }


        if (!hasRunFindShardNotes) {
            findShardNotes();
            // Set the flag to true after running findShardNotes
            hasRunFindShardNotes = true;
        }
    }




    function findShardNotes() {
        const cxFeedItems = document.querySelectorAll('.cxfeeditem.feeditem');

        if (cxFeedItems.length > 0) {
            for (let n = 0; n < cxFeedItems.length; n++) {
                // Check if the innerText of the current item contains "Automation Support"
                if (cxFeedItems[n].innerText.includes("Automation Support")) {
                    // Log the innerText of the current item to the console
                    console.log("Matching item: " + cxFeedItems[n].innerText);

                    // Find the child element with the class 'feeditemtext cxfeeditemtext'
                    let feedItemTextElement = cxFeedItems[n].querySelector('.feeditemtext.cxfeeditemtext');

                    // Check if the element is found and log its innerText to the console
                    if (feedItemTextElement) {
                        console.log("Feed Item Text: " + feedItemTextElement.innerText);
                    }
                }
            }
        }
    }




    // Check for new "Show More" buttons and execute actions if found
    const intervalId = setInterval(executeActions, 2000);
})();
