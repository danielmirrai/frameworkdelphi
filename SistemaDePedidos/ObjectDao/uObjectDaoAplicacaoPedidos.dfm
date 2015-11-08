inherited ObjectDaoAplicacaoPedidos: TObjectDaoAplicacaoPedidos
  inherited FBConnection: TSQLConnection
    Params.Strings = (
      'DriverName=Interbase'
      
        'Database=Localhost:C:\Delphi\Pedido\SistemaDePedidos\DB\DATAPEDI' +
        'DOS.FDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    Connected = True
  end
end
