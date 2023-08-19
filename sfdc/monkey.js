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

            // todo 01467651, I need findShardNotes to run multiple times for an unknown reason.
            //hasRunFindShardNotes = true;
        }
    }




    function findShardNotes() {

        let contentsArray = [];
        // Find all elements with the class '.cxfeeditem.feeditem'
        const cxFeedItems = document.querySelectorAll('.cxfeeditem.feeditem');

        if (cxFeedItems.length > 0) {
            for (let n = 0; n < cxFeedItems.length; n++) {
                // Check if the innerText of the current item contains "Automation Support"
                if (cxFeedItems[n].innerText.includes("Handover")) {
                    // Log the innerText of the current item to the console
                    console.log("Matching item: " + cxFeedItems[n].innerText);

                    // Find and log the text of element with the class 'feeditemtext cxfeeditemtext'
                    const feedItemTextElement = cxFeedItems[n].querySelector('.feeditemtext.cxfeeditemtext');
                    if (feedItemTextElement) {
                        console.log("Feed Item Text: " + feedItemTextElement.innerText);
                        contentsArray.push(feedItemTextElement.innerText);
                    }

                    // Find and log the text of element with the class 'feeditemtimestamp'
                    const timeStampElement = cxFeedItems[n].querySelector('.feeditemtimestamp');
                    if (timeStampElement) {
                        console.log("Timestamp: " + timeStampElement.innerText);
                        contentsArray.push(timeStampElement.innerText);
                    }
                }
            }
        }

        if (contentsArray.length > 0) {
            // Open a new popup window
            const popup = window.open('', '_blank', 'width=600,height=400,scrollbars=yes,resizable=yes');

            // Write the contents of the array into the popup window, separated by horizontal lines
            popup.document.write('<html><head><title>Popup</title></head><body>');
            popup.document.write(contentsArray.map(content => '<pre>' + content + '</pre><hr>').join(''));
            popup.document.write('</body></html>');

            // Close the popup window's document stream
            popup.document.close();
        }
    }

    // Call the function to test it
    findShardNotes();





    // Check for new "Show More" buttons and execute actions if found
    const intervalId = setInterval(executeActions, 2000);
})();
