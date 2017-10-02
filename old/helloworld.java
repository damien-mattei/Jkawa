/* Hello World Java Program */

// javac -cp '.:/usr/local/share/java/kawa-2.1.jar' -d . helloworld.java
// java -cp '.:/usr/local/share/java/kawa-2.1.jar' eu.oca.kawafunct.helloworld

package eu.oca.kawafunct;

//import 2dVector;

//import $N2dVector;

import gnu.expr.RunnableModule;
import gnu.lists.LList;
import gnu.lists.Pair;

import kawa.standard.Scheme;
//import gnu.mapping.Environment;

class helloworld  {

    //$N2dVector vec = new $N2dVector( 1, 2);
    //2dVector vec = new 2dVector( 1, 2);
    
    
    public static void main(String[] args) {

	Scheme.registerEnvironment(); // if you do not do that you will be sooner or later in serious troubles...

	//Environment.setCurrent(new Scheme().getEnvironment());
	
	Vector2D vec = new Vector2D( 1, 2);

	Object[] lst = {2, 3};
	
        System.out.println("Hello World!");
	//fun1(2,3);
	double res=vec.norm();
	System.out.println(res);
	//Object result = vec.plus.applyN(lst);

	LList glst = new LList();
	//glst = glst.list2(2,3); // works also
	glst = LList.list2(2,3);
	System.out.println("glst : "+glst);
	Object result0 = vec.plus(glst);
	System.out.println("result0 :"+result0);
	int r = (int) result0;
	System.out.println("r : "+r);


	Pair pair = new Pair(2, LList.Empty);
	Pair pair2 = new Pair(3, pair);
	LList glst2 = new LList();
	glst2 = pair2;
	System.out.println("glst2 : "+glst2);
	Object result = vec.plus(glst2);
	System.out.println("result : "+result);

	Object result1 = vec.carre(glst);
	System.out.println("result1 :"+result1);


	
	//String servletRealPath = "/Users/mattei/SidonieAccueilD.htm"; //index.html");
	//String servletRealPath ="/home/mattei/Dropbox/Sidonie/web/scripts/SidonieAccueilD.htm";
	String servletRealPath ="/home/mattei/NetBeansProjects/Sidonie/web/scripts/SidonieAccueilD.htm";
	
	//KawaCode kc = new KawaCode();
	Counter cnt = new Counter("/data_sidonie",servletRealPath);

	System.out.println("Counter ok");
	
	cnt.work();
	
	String jstr;// =  kc.blabla(); //fstr.toString();

	
	jstr = cnt.getDataDir(); //pwd();
	System.out.println("jstr :"+jstr);
	
	String jstrPwd = cnt.pwd();
	System.out.println("jstrPwd :"+jstrPwd);
	
	String jcounterPathFileName = cnt.getCounterPathFileName();
	System.out.println("jcounterPathFileName :"+jcounterPathFileName);
    
	String response = cnt.getHtmlCounterPage();
	System.out.println("response :"+response);
	
    }
}
