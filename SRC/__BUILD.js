// load UJS.
require('./UJS-NODE.js');

/*
 * build ULUA.
 */
RUN(function() {
	'use strict';

	var
	// BASE_CONTENT
	BASE_CONTENT = '-- Welcome to ULUA! (http://uppercase.io)\n\n',

	//IMPORT: path
	path = require('path'),

	// log.
	log = function(msg) {
		console.log('ULUA BUILD: ' + msg);
	},

	// scan folder.
	scanFolder = function(scripts, path) {
		//REQUIRED: scripts
		//REQUIRED: path

		FIND_FILE_NAMES({
			path : path,
			isSync : true
		}, function(fileNames) {
			EACH(fileNames, function(fileName) {
				scripts.push(path + '/' + fileName);
			});
		});

		FIND_FOLDER_NAMES({
			path : path,
			isSync : true
		}, function(folderNames) {
			EACH(folderNames, function(folderName) {
				scanFolder(scripts, path + '/' + folderName);
			});
		});
	},

	// save.
	save = function(scriptPaths, path, isToSaveMin) {

		var
		// content
		content,

		// minify result
		minifyResult;

		EACH(scriptPaths, function(scriptPath) {

			if (content === undefined) {
				content = BASE_CONTENT;
			} else {
				content += '\n';
			}

			content += READ_FILE({
				path : scriptPath,
				isSync : true
			}).toString();
		});

		WRITE_FILE({
			path : '../' + path + '.lua',
			content : content,
			isSync : true
		});
	},

	// build folder.
	buildFolder = function(commonScripts, name, isToSaveMin) {

		var
		// scripts
		scripts = [];

		log('BUILD [' + name + ']');

		scanFolder(scripts, name);

		save(COMBINE([commonScripts, scripts]), 'ULUA-' + name, isToSaveMin);
	},

	// copy folder.
	copyFolder = function(from, to, name) {

		FIND_FILE_NAMES({
			path : from,
			isSync : true
		}, function(fileNames) {
			EACH(fileNames, function(fileName) {
				COPY_FILE({
					from : from + '/' + fileName,
					to : '../' + to + '/' + fileName,
					isSync : true
				});
			});
		});

		FIND_FOLDER_NAMES({
			path : from,
			isSync : true
		}, function(folderNames) {
			EACH(folderNames, function(folderName) {
				copyFolder(from + '/' + folderName, to + '/' + folderName, folderName);
			});
		});
	};

	INIT_OBJECTS();

	RUN(function() {

		var
		// common scripts
		commonScripts = [];

		log('BUILD [COMMON]');

		//commonScripts.push('COMMON/CONFIG.lua');
		//commonScripts.push('COMMON/METHOD.lua');
		commonScripts.push('COMMON/OOP/CLASS.lua');
		//commonScripts.push('COMMON/OOP/OBJECT.lua');
		//commonScripts.push('COMMON/OOP/INIT_OBJECTS.lua');

		scanFolder(commonScripts, 'COMMON/BOX');
		scanFolder(commonScripts, 'COMMON/UTIL');

		save(commonScripts, 'ULUA-COMMON');

		buildFolder(commonScripts, 'LUVIT');

		log('DONE.');
	});
});
