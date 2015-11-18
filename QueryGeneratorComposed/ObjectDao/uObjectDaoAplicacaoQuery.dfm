inherited ObjectDaoAplicacaoQuery: TObjectDaoAplicacaoQuery
  inherited FBConnection: TSQLConnection
    Params.Strings = (
      'DriverName=Interbase'
      
        'Database=localhost:C:\Mega\Projetos\Fontes\Framework\trunk\Siste' +
        'maDePedidos\DB\DATAPEDIDOS.FDB'
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
