select P.FirstName as FirstName, p.LastName as LastName, A.AppointmentDate as DataConsulta, 
C.Description as DescricaoCurso, pla.Description as DescricaoPlano, pla.Approved as Aprovado
from dbo.tbAppointment A inner join dbo.tbRPatientCourse rTC on A.IDPatientCourse = rTC.ID
inner join dbo.tbPatient P on rTC.IDPatient = P.ID 
inner join dbo.tbRCoursePlan rCP on rTC.IDCourse = rCP.IDCourse
inner join dbo.tbPlan pla on rCP.IDPlan = pla.ID 
inner join dbo.tbCourse C on rTC.IDCourse = C.ID;



