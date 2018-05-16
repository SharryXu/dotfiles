// Setup default banner
var welcome = "Welcome to use MongoDB!";

print(welcome);

// Setup Prompt
prompt = function () {
	var promptString = "";
	var currentDateTime = new Date();

	promptString += "{" + currentDateTime.toLocaleDateString() + " " + currentDateTime.toLocaleTimeString() + "} ";

	if (typeof db === 'undefined')
	{
		promptString += "(nodb) ";
	}
	else
	{
		promptString += db.getName() + " ";

		printDBsPotentialError();
	}

	promptString += "> ";

	return promptString;
};

var printDBsPotentialError = function () {
	if (typeof db !== 'undefined')
	{
		try {
			db.runCommand({getLastError: 1});
		}
		catch (e) {
			print("======== Last error ==========");
			print(e);
			print("==============================");
		}
	}
};

// Prompt when delete database
var dropDatabaseCount = 0;
var dropDatabase = DB.prototype.dropDatabase;

DB.prototype.dropDatabase = function () {
    if (dropDatabaseCount === 0)
    {
        print("Please type this command again to verify this operation.");

        dropDatabaseCount++;
    }
    else
    {
        dropDatabase().call(this);

        dropDatabaseCount = 0;
    }
};

// Prompt when delete database
var dropCollectionCount = 0;
var dropCollection = DBCollection.prototype.drop;

DBCollection.prototype.drop = function () {
    if (dropCollectionCount === 0)
    {
        print("Please type this command again to verify this operation.");

        dropCollectionCount++;
    }
    else
    {
        if (typeof db !== 'undefined')
        {
            var collectionName = this.getName();

            db.runCommand({"drop": collectionName});
        }

        dropCollectionCount = 0;
    }
};
