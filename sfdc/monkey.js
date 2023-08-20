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


        findShardNotes();
        findDownloadLinks();

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

        // var case_number = document.querySelector('.tabText').textContent;
        // var case_number = document.getElementsByClassName('tabText')[0].textContent;
        var case_number = document.getElementById('cas2_ileinner').textContent;
        var case_title = document.getElementById('cas14_ileinner').textContent;


        if (contentsArray.length > 0) {
            // Open a new popup window
            const popup = window.open('', case_number, 'width=600,height=400,scrollbars=yes,resizable=yes');

            // Write the contents of the array into the popup window, separated by horizontal lines

            popup.document.write('<html><head><title>' + case_number + ' </title></head><body>');
            popup.document.write('<h1>' + case_title + '</h1>');
            popup.document.write(contentsArray.map(content => '<pre>' + content + '</pre><hr>').join(''));
            popup.document.write('</body></html>');

            // Close the popup window's document stream
            popup.document.close();

        }
    }


    function generateCurlCommand(text) {
        // Extract the URL from the text using regex
        const urlMatch = text.match(/https:\/\/upload\.elastic\.co\/d\/[a-z0-9]+/i);
        if (!urlMatch) {
            throw new Error("URL not found in the text");
        }
        const url = urlMatch[0];

        // Extract the Authorization Token from the text using regex
        const tokenMatch = text.match(/Authorization Token: (\S+)/);
        if (!tokenMatch) {
            throw new Error("Authorization Token not found in the text");
        }
        const token = tokenMatch[1];

        // Extract the file name with potential spaces
        const fileNameMatch = text.match(/File name: (.+?\.\w+)/);
        if (!fileNameMatch) {
            throw new Error("File name not found in the text");
        }
        const fileName = fileNameMatch[1];

        // Extract the timestamp from the text
        const timestampMatch = text.match(/\d{4}\/\d{2}\/\d{2} at \d{2}:\d{2}/);
        if (!timestampMatch) {
            throw new Error("Timestamp not found in the text");
        }
        const timestamp = timestampMatch[0];

        // Generate the curl command
        const curlCommand = `curl -L -H 'Authorization: ${token}' -o '${fileName}' ${url} # uploaded: ${timestamp}`;
        return curlCommand;
    }




    function findDownloadLinks() {

        let contentsArray = [];
        // Find all elements with the class '.cxfeeditem.feeditem'
        const cxFeedItems = document.querySelectorAll('.cxfeeditem.feeditem');



        if (cxFeedItems.length > 0) {
            for (let n = 0; n < cxFeedItems.length; n++) {
                // Check if the innerText of the current item contains "Automation Support"
                if (cxFeedItems[n].innerText.includes("Upload for Elastic Cloud")) {
                    // Log the innerText of the current item to the console
                    console.log("Matching item: " + cxFeedItems[n].innerText);
                    contentsArray.push(generateCurlCommand(cxFeedItems[n].innerText));


                }
            }
        }


        var case_number = document.getElementById('cas2_ileinner').textContent;
        var case_title = document.getElementById('cas14_ileinner').textContent;



        if (contentsArray.length > 0) {
            // Open a new popup window
            const popup = window.open('', case_number + 'curl' , 'width=600,height=400,scrollbars=yes,resizable=yes');

            // Write the contents of the array into the popup window, separated by horizontal lines

            popup.document.write('<html><head><title>' + case_number + '</title></head><body>');
            popup.document.write('<h1>' + '#' + case_title + '</h1>');
            popup.document.write(contentsArray.map(content => '<pre>' + content + '</pre><hr>').join(''));
            popup.document.write('</body></html>');

            // Close the popup window's document stream
            popup.document.close();
        }
    }


    // Check for new "Show More" buttons and execute actions if found
    const intervalId = setInterval(executeActions, 3000);
})();
