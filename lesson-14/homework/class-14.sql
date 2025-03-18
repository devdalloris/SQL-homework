use class14; 
go
DECLARE @body NVARCHAR(MAX);

SET @body = '
    <style>
        #indexMetadata {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }
        #indexMetadata td, #indexMetadata th {
            border: 1px solid #ddd;
            padding: 8px;
        }
        #indexMetadata tr:nth-child(even) {background-color: #f2f2f2;}
        #indexMetadata tr:hover {background-color: #ddd;}
        #indexMetadata th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #04AA6D;
            color: white;
        }
    </style>
    <body>
        <h1>Index Metadata</h1>
        <table id="indexMetadata">
            <tr>
                <th>Table Name</th>
                <th>Index Name</th>
                <th>Index Type</th>
                <th>Column Type</th>
            </tr>';

SELECT @body = @body + '
            <tr>
                <td>' + t.name + '</td>
                <td>' + i.name + '</td>
                <td>' + CASE i.type
                            WHEN 1 THEN 'Clustered'
                            WHEN 2 THEN 'Non-Clustered'
                            WHEN 3 THEN 'XML'
                            WHEN 4 THEN 'Full-Text'
                            WHEN 5 THEN 'Spatial'
                            ELSE 'Other'
                        END + '</td>
                <td>' + c.name + '</td>
            </tr>'
FROM sys.indexes AS i
JOIN sys.objects AS t ON i.object_id = t.object_id
JOIN sys.index_columns AS ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns AS c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE t.type = 'U' 
ORDER BY t.name, i.name;

SET @body = @body + '
        </table>
    </body>';


EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'DallorisGmailProfile',
    @recipients = 'dollydolly2021dolly@gmail.com', 
    @subject = 'Report',
    @body = @body,
    @body_format = 'HTML';